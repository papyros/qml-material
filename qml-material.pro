TEMPLATE = subdirs

SUBDIRS = src tests

tests.depends = src

OTHER_FILES = $$PWD/README.md $$PWD/CHANGELOG.md
