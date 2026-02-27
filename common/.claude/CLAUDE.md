# CLAUDE.md

## General Instructions

- No yapping, keep it concise and reduce the use of emojis

## Plan Mode

- Make the plan extremely concise. Sacrifice grammar for the sake of concision.
- Interview me for answers to any questions and adjust the plan accordingly
- When working through a multi-stage plan, commit progress at the completion of each step and ask before proceeding to the next step.
- When fixing known issues, practise test-driven development. Plan to write a failing test first to confirm the behaviour is as suspected, then fix the issue and re-run the test. After fixing the issue propose refactoring to tidy up the affected area if it is needed.

## PR Preferences
- No "Summary" heading or "Test plan" section in PR descriptions. Just bullet points and any relevant data directly.

## Code Standards

- Do not add any unnecessary function docstrings or "what" comments, instead use good function naming and overall
  module structure so that code is self-documenting whenever possible. Comments should **only** be used when
  the behaviour is not obvious and needs some explanation.
- Unit tests should be named with the following standard: `test_<function_tested>_when_<test_behaviour_when_predicate>`.
  For example, if testing a function `do_something`, and examining the behaviour when duplicates input, the test name
  would be `test_do_something_detects_duplicates_when_duplicates_input`

## Dev Environment - Python

- Use poetry to manage dependencies and run any python scripts and tools whenever a `pyproject.toml` file is found that uses poetry.
- Use the available linting and type checking tools in the current repository dependencies.
- Tests can be run using `pytest`, optionally including the specific test module for faster execution, and/or the specific test for quickest focus tests.

## Dev Environment - Rust

- Always run formatting with `cargo fmt`
- Run linting with `cargo clippy --all --tests --all-features --no-deps -- -D warnings`

