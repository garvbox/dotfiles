#!/usr/bin/env python3
import json
import re
import sys

BLOCKED = [
    (r"\bbrew\s+services\s+(start|run|restart)\b.*\bpostgres", "brew services start of postgresql"),
    (r"\bpg_ctl(cluster)?\b.*\b(start|restart)\b", "pg_ctl start"),
    (r"(^|[;&|]\s*)(sudo\s+)?(/\S*/)?(postgres|postmaster)\s+(-D|-c|--)", "direct postgres server launch"),
    (r"\b(systemctl|service)\s+(start|restart)\s+\S*postgres", "systemd/service start of postgresql"),
    (r"\blaunchctl\s+(load|start|bootstrap|kickstart)\b.*postgres", "launchctl start of postgresql"),
    (r"\bdocker\s+(container\s+)?(start|restart)\b.*postgres", "docker start of a postgres container"),
    (r"\bdocker\s+run\b.*\bpostgres\b", "docker run of a postgres image"),
    (r"\binitdb\b", "initdb"),
]

try:
    payload = json.load(sys.stdin)
except Exception:
    sys.exit(0)

command = payload.get("tool_input", {}).get("command", "")

for pattern, label in BLOCKED:
    if re.search(pattern, command, re.IGNORECASE):
        print(json.dumps({
            "hookSpecificOutput": {
                "hookEventName": "PreToolUse",
                "permissionDecision": "deny",
                "permissionDecisionReason": (
                    f"Blocked: {label}. Never start a postgres server. "
                    "If the dev-env docker container is not running, stop and tell the user — "
                    "do not start a local postgres as a workaround."
                ),
            }
        }))
        sys.exit(0)

sys.exit(0)
