# AGENTS.md

## General Instructions

- No yapping, keep it concise and reduce the use of emojis
- When fixing smaller specific issues as a standalone task, practise test-driven development. Write a failing test first to confirm the behaviour is as suspected, then fix the issue and re-run the test. After fixing the issue propose refactoring to tidy up the affected area if it is needed.
- When working through a multi-step process or list of TODOs, commit progress at the completion of each step, stop and ask before proceeding to the next step.


## Plan Mode

- Make the plan extremely concise. Sacrifice grammar for the sake of concision.

## PR Preferences

- PR descriptions should be brief, the reviewer will need to look at the code and understand it so too much content in the description is distracting.
- Do NOT put a Summary heading section in PR descriptions. 
- Do NOT put a Testing or Test Plan section in PR descriptions.

## Code Standards

- Do not add any unnecessary function docstrings or "what" comments, instead use good function naming and overall
  module structure so that code is self-documenting whenever possible. Comments should **only** be used when
  the behaviour is not obvious and needs some explanation.
- Unit tests should be named with the following standard: `test_<function_tested>_when_<test_behaviour_when_predicate>`.
  For example, if testing a function `do_something`, and examining the behaviour when duplicates input, the test name
  would be `test_do_something_detects_duplicates_when_duplicates_input`

## Dev Environment - Python

- Use poetry to manage dependencies and run any python scripts and tools whenever a `pyproject.toml` file is found that uses poetry.
- Always use the available linting, formatting and type checking tools in the current repository dependencies before committing changes.
- Tests should be run using `pytest`, preferring to run tests in the specific area being changed.

## Dev Environment - Rust

- Always run formatting with `cargo fmt`
- Run linting with `cargo clippy --all --tests --all-features --no-deps -- -D warnings`

