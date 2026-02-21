# CLAUDE.md

## General Instructions

- No yapping, keep it concise and reduce the use of emojis

## Plan Mode

- Make the plan extremely concise. Sacrifice grammar for the sake of concision.
- Interview me for answers to any questions and adjust the plan accordingly
- When fixing known issues, practise test-driven development. Plan to write a failing test first to confirm the behaviour is as suspected, then fix the issue and re-run the test. After fixing the issue propose refactoring to tidy up the affected area if it is needed.

## Code Standards

- Do not add any unnecessary function docstrings or "what" comments, instead use good function naming and overall
  module structure so that code is self-documenting whenever possible. Comments should **only** be used when
  the behaviour is not obvious and needs some explanation.
- Unit tests should be named with the following standard: `test_<function_tested>_<test_behaviour_when_predicate>`.
  For example, if testing a function `do_something`, and examining the behaviour when duplicates input, the test name
  would be `test_do_something_detects_duplicates_when_duplicates_input`

## Dev Environment - Python

- Use poetry to manage dependencies and run any python scripts and tools whenever a `pyproject.toml` file is found that uses poetry.
- Use the available linting and type checking tools in the current repository dependencies.
- Tests can be run using `pytest`, optionally including the specific test module for faster execution, and/or the specific test for quickest focus tests.

