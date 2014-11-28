TEMPLATE = app
TARGET = tst_material
CONFIG += warn_on qmltestcase
SOURCES += tests.cpp
IMPORTPATH += $$PWD/../modules

OTHER_FILES += tst_card.qml \
    tst_pagestack.qml
