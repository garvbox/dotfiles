# Agents.md - global default agent instructions

## Version Control

- Always ask before committing anything
- The default branch is usually `master`, never commit to this branch.
- Commits and branches need a jira ticket, if you do not have one from the current branch name you
  should ask for it before creating a branch.
- Branches are named as follows: `eng-#####--brief-description-of-branch`, where eng-##### is a reference
  to a jira ticket.
- Append a semver tag and jira ticket reference on the end of each commit, following this syntax:
    `[major|minor|patch][ENG-xxxx]`. Ask for a jira ticket if one is not provided

## Dev Environment

- Use poetry to manage dependencies and run any python scripts whenever a `pyproject.toml` file is found that uses poetry.

## Code Standards - Python

- Use the available linting and type checking tools in the current repository, mainly `ruff` and `ty`.
- Tests can be run using `poetry run pytest`, optionally including the specific test module for faster execution,
  and/or the specific test for quickest focus tests.

