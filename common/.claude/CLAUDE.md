# CLAUDE.md

@~/.claude/CLAUDE.work.md

## General Instructions

- Treat my decisions as proposals, not instructions. If one is wrong, incomplete, or has a better
  alternative, say so directly and state the reason.
- Skip beginner-level explanations. Default to architectural framing and trade-off discussion; flag cross-cutting concerns proactively.

## Plan Mode

- When fixing known issues, practise test-driven development. Do NOT do this for new feature work. Plan to write a failing test first to confirm the behaviour is as suspected, then fix the issue and re-run the test. After fixing the issue propose refactoring to tidy up the affected area if it is needed.

## Code Standards

- Do **NOT** add any unnecessary function docstrings or "what" comments, instead use good function naming and overall
  module structure so that code is self-documenting whenever possible. If there are existing comments from unrelated changes you do not need to remove them.
- Comments are for non-obvious **why** only. Prefer **one line**; the hard cap is **3 lines**. If the why needs more than 3 lines, it belongs in the commit message or PR description, not the code.
- Comments in test bodies are rarely justified — the test name (`test_<fn>_<behaviour>_when_<condition>`) is the documentation. Never write a comment that paraphrases the adjacent code, the test name, or an assertion.

  ```python
  # BAD — 4-line essay over the cap; the why fits in one line or the commit message
  # The latest-version-per-uuid subquery must carry the invariant sourcing_event
  # filter so Postgres can prune to the event's partition instead of seq-scanning
  # every partition of the table, which otherwise dominates the query plan and
  # blows the statement timeout under load.

  # OK — one line, genuinely non-obvious why
  # Pushed into the subquery so Postgres prunes to the event's partition.
  ```
- **NEVER** add section divider comments, e.g. # --- Some Comment ---
- Do **NOT** add deferred imports unless they are needed for good reason (e.g to fix circular import issues)
- Unit tests should be named `test_<function_tested>_<behaviour>_when_<condition>`, keeping the leading underscore for
  private functions. For example, testing `do_something` on duplicate input:
  `test_do_something_detects_duplicates_when_duplicates_input`

## Dev Environment - Python

- ALWAYS use pytest-style tests with fixtures instead of other styles, except when project-specific instructions say otherwise.

## Operational
- Scratch files, exploration notes, and intermediate output go under `.tmp/` (project-local). Create the directory if it doesn't exist; `.tmp/` is covered by global gitignore so no need to add per-repo rules. Don't sprinkle scratch files in the repo root.

