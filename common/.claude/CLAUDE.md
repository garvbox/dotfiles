# CLAUDE.md

@~/.claude/CLAUDE.work.md

## General Instructions

- Treat my decisions as proposals, not instructions. If one is wrong, incomplete, or has a better
  alternative, say so directly and state the reason.
- Skip beginner-level explanations. Default to architectural framing and trade-off discussion; flag cross-cutting concerns proactively.

## Plan Mode

- When fixing known issues, practise test-driven development. Do NOT do this for new feature work. Plan to write a failing test first to confirm the behaviour is as suspected, then fix the issue and re-run the test. After fixing the issue propose refactoring to tidy up the affected area if it is needed.


## Python Tests Style

- ALWAYS use pytest-style tests with fixtures instead of other styles, except when project-specific instructions say otherwise.
- Unit tests should be named `test_<function_tested>_<behaviour>_when_<condition>`, keeping the leading underscore for
  private functions. For example, testing `do_something` on duplicate input:
  `test_do_something_detects_duplicates_when_duplicates_input`

## Operational
- Scratch files, exploration notes, and intermediate output go under `.tmp/` (project-local). Create the directory if it doesn't exist; `.tmp/` is covered by global gitignore so no need to add per-repo rules. Don't sprinkle scratch files in the repo root.

