# django-app-starter

This is a project template for building resuable django extensions/apps with proper tooling, that I use for my projects.

## Install

```shell
# Pull the template from Codeberg...
$ uv run --with=django django-admin startapp \
    --extension=ini,py,toml,sh \
    --name justfile \
    --template=https://github.com/oliverandrich/django-app-starter/archive/main.zip \
    example_app

# Setup the project
$ just boostrap
```

## Usage

```shell
# Upgrade/install all dependencies defined in pyproject.toml
just upgrade

# Run test suite
just test

# Run test suite using all support Django and Python versions
just test-all

# Run the dev server for mkdocs
just serve-docs
```

## License

This software is licensed under [MIT license](./LICENSE).
