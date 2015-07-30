TEMPLATE = app
TARGET = tst_material
CONFIG += warn_on qmltestcase
SOURCES += tests.cpp
IMPORTPATH += $$PWD/../modules

OTHER_FILES += tst_card.qml \
    tst_document.qml \
    tst_httplib.qml \
    tst_pagestack.qml \
    tst_promise.qml
