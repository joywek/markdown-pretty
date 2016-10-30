# markdown-pretty Makefile

.PHONY : help
help:
	@echo 'Usage: make <subcommand>'
	@echo ''
	@echo 'Subcommands:'
	@echo '    install       Install Markdown-Pretty locally'
	@echo '    deploy        Register and upload a new release to PyPI'
	@echo '    build         Build a source distribution'
	@echo '    docs          Build documentation'
	@echo '    test          Run all tests'
	@echo '    update-tests  Generate html files for updated text files in tests'
	@echo '    clean         Clean up the source directories'

.PHONY : install
install:
	python setup.py install

.PHONY : deploy
deploy:
	python setup.py register
	python setup.py sdist --formats zip,gztar upload

.PHONY : build
build:
	python setup.py sdist --manifest-only
	python setup.py sdist --formats zip,gztar

.PHONY : docs
docs:
	python setup.py build_docs --force
	cd build/docs && zip -r ../docs.zip .

.PHONY : test
test:
	@nosetests

.PHONY : update-tests
update-tests:
	python run-tests.py update

.PHONY : clean
clean:
	rm -f MANIFEST
	rm -f test-output.html
	rm -f *.pyc
	rm -f pretty/*.pyc
	rm -f *.bak
	rm -f pretty/*.bak
	rm -f *.swp
	rm -f pretty/*.swp
	rm -rf build
	rm -rf dist
	rm -rf tmp
	rm -rf python_markdown_pretty.egg-info
