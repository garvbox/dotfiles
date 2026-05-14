# CLAUDE.md

## General Instructions

- No yapping, keep it concise and reduce the use of emojis

## Plan Mode

- Interview me for answers to any questions and adjust the plan accordingly
- When fixing known issues, practise test-driven development. Do NOT do this for new feature work. Plan to write a failing test first to confirm the behaviour is as suspected, then fix the issue and re-run the test. After fixing the issue propose refactoring to tidy up the affected area if it is needed.

## Git Workflow
- Commit in small atomic chunks — each commit should focus on one functional change
- Structure commits so they tell a story for a reviewer (e.g. add abstraction → use it in module A → use it in module B → fix edge case)
- Only stage files related to the specific change, not unrelated modifications
- Use `git add -p` when a single file contains changes for multiple commits
- Always verify staged changes match the commit message before committing

## PR Preferences
- Do **NOT** include any headings in PR descriptions. A PR should be brief and to the point, it can have a sentence or two at the top to explain the reasons for the change, and should just call out noteworthy elements for the reviewer or important context.

## Code Standards

- Do **NOT** add any unnecessary function docstrings or "what" comments, instead use good function naming and overall
  module structure so that code is self-documenting whenever possible. Comments should **only** be used when
  the behaviour is not obvious and needs some explanation. If there are existing comments from unrelated changes you do not need to remove them.
- **NEVER** add section divider comments, e.g. # --- Some Comment ---
- Unit tests should be named with the following standard: `test_<function_tested>_when_<test_behaviour_when_predicate>`.
  For example, if testing a function `do_something`, and examining the behaviour when duplicates input, the test name
  would be `test_do_something_detects_duplicates_when_duplicates_input`

## Dev Environment - Python

- Use poetry to manage dependencies and run any python scripts and tools whenever a `pyproject.toml` file is found that uses poetry.
- ALWAYS use pytest-style tests with fixtures instead of other styles, except when project-specific instructions say otherwise.
- Tests can be run using `pytest`, optionally including the specific test module for faster execution, and/or the specific test for quickest focus tests.

