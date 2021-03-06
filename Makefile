VERBOSE ?= @

python-packages := python_style tests

.PHONY: check check_black check_isort check_flake8 check_pylint check_mypy check_pydocstyle format test install install_devel install_edge clean

all: check test

check: check_black check_isort check_flake8 check_pylint check_mypy check_pydocstyle

check_black:
	black --check --diff --line-length 100 $(python-packages)

check_isort:
	isort --check --diff $(python-packages)

check_flake8:
	pflake8 $(python-packages)

check_pylint:
	pylint $(python-packages)

check_mypy:
	mypy --pretty $(python-packages)

check_pydocstyle:
	pydocstyle $(python-packages)

format:
	black -l 100 $(python-packages)
	isort $(python-packages)

test:
	python3 -m pytest -n$(shell nproc) -vv tests

install:
	pip3 install --force-reinstall .

install_devel:
	pip3 install ".[devel]"

install_devel_edge: install_devel
	tools/upgrade_dependencies.py

clean:
	rm -rf .coverage .mypy_cache .pytest_cache
