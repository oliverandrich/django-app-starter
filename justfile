set export
set dotenv-load

VENV_DIRNAME := ".venv"

@_default:
    just --list

[private]
@check_uv:
    if ! command -v uv &> /dev/null; then \
        echo "uv could not be found. Exiting."; \
        exit; \
    fi

# setup development environment
@bootstrap: check_uv
    echo "\033[32m✓\033[0m Initialized git repository."
    git init

    echo "\033[32m✓\033[0m Installed dependencies."
    just upgrade

    echo "\033[32m✓\033[0m Initial commit."
    git add -A .
    git commit -m "Initial commit"

    echo "\033[32m✓\033[0m Installed pre-commit hook."
    uvx --with pre-commit-uv pre-commit install

    echo
    echo "\033[32mHappy coding!\033[0m"

# upgrade/install all dependencies defined in pyproject.toml
@upgrade: check_uv
    uv sync --all-extras --upgrade
    uvx --with pre-commit-uv pre-commit autoupdate

# run pre-commit rules on all files
@lint: check_uv
    uvx --with pre-commit-uv pre-commit run --all-files

# create migrations
@makemigrations: check_uv
    uv run python -m django makemigrations --settings tests.settings {{ app_name }}

# run test suite
@test: check_uv
    uv run python -m coverage run -m django test --settings tests.settings
    uv run python -m coverage report

# run test suite
@test-all: check_uv
    uvx --with tox-uv tox

# serve docs during development
@serve-docs: check_uv
    uvx  --with markdown-callouts --with mkdocs-material mkdocs serve
