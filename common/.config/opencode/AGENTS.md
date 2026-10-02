# AGENTS.md

## General Instructions

- When fixing existing issues, practise test-driven development. Plan to write a failing test first to confirm the behaviour is as suspected, then fix the issue and re-run the test. After fixing the issue propose refactoring to tidy up the affected area if it is needed.

## Version Control

- Always ask before committing anything
- The default branch is usually `master`, never commit to this branch.

## PR Preferences
- No heading or sections in PR descriptions. Open with a brief paragraph describing the motivation for the change, followed by at most 3-4 bullet points and any relevant data following if needed at the end. Keep it brief and to the point, calling out only important high level details. Commits and the code changes contain the detail.

## Code Standards

### Comments and Docstrings
- Do not add any unnecessary function docstrings or "what" comments, instead use good function naming and overall
  module structure so that code is self-documenting whenever possible. Comments should **only** be used when
  the behaviour is not obvious and needs some explanation.
- NEVER add section divider comments, e.g. # --- Some Comment ---

### Unit Tests
- Unit tests should be named with the following standard: `test_<function_tested>_when_<test_behaviour_when_predicate>`.
  For example, if testing a function `do_something`, and examining the behaviour when duplicates input, the test name
  would be `test_do_something_detects_duplicates_when_duplicates_input`
- 
