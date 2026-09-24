#!/usr/bin/env python3
"""PostToolUse hook: flag overly long comment blocks in .py edits."""

import json
import re
import sys

NON_POLICY_COMMENT = re.compile(r"^#!|^#\s*(noqa|type:\s*ignore|pragma|ruff:|fmt:)")
MAX_COMMENT_LINES = 3


def comment_lines(text):
    lines = []
    for raw in text.splitlines():
        stripped = raw.strip()
        if stripped.startswith("#") and not NON_POLICY_COMMENT.match(stripped):
            lines.append(stripped)
    return lines


def main():
    try:
        payload = json.load(sys.stdin)
    except (json.JSONDecodeError, ValueError):
        return 0

    tool_input = payload.get("tool_input") or {}
    file_path = tool_input.get("file_path") or ""
    if not file_path.endswith(".py"):
        return 0

    tool_name = payload.get("tool_name", "")
    if tool_name == "Edit":
        added = tool_input.get("new_string") or ""
        existing = set(comment_lines(tool_input.get("old_string") or ""))
    elif tool_name == "Write":
        added = tool_input.get("content") or ""
        existing = set()
    else:
        return 0

    consecutive = 0
    for raw in added.splitlines():
        stripped = raw.strip()
        is_comment = stripped.startswith("#") and not NON_POLICY_COMMENT.match(stripped)
        is_new = is_comment and stripped not in existing
        consecutive = consecutive + 1 if is_new else 0
        if consecutive > MAX_COMMENT_LINES:
            print(
                f"Comment policy: added a comment block longer than {MAX_COMMENT_LINES} lines. "
                "Comments are for non-obvious why only — keep them brief. "
                f"Compress to at most {MAX_COMMENT_LINES} lines.",
                file=sys.stderr,
            )
            return 2
    return 0


if __name__ == "__main__":
    sys.exit(main())
