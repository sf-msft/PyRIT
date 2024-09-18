.PHONY: all pre-commit mypy test test-cov-html test-cov-xml

CMD:=python -m
PYMODULE:=pyrit
TESTS:=tests

all: pre-commit

pre-commit:
	$(CMD) isort --multi-line 3 --recursive $(PYMODULE) $(TESTS)
	pre-commit run --all-files

mypy:
	$(CMD) mypy $(PYMODULE) $(TESTS)

test:
	$(CMD) pytest --cov=$(PYMODULE) $(TESTS)

test-cov-html:
	$(CMD) pytest --cov=$(PYMODULE) $(TESTS) --cov-report html

test-cov-xml:
	$(CMD) pytest --cov=$(PYMODULE) $(TESTS) --cov-report xml --junitxml=junit/test-results.xml --doctest-modules

docs-build:
	jb toc from-project ./doc -e .ipynb -e .md -f jb-book > ./doc/_toc.yml
	jb build ./doc

#clean:
#	git clean -Xdf # Delete all files in .gitignore
