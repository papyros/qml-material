TEMPLATE = app
TARGET = tst_material
CONFIG += warn_on qmltestcase
SOURCES += tests.cpp

RESOURCES += icons/icons.qrc

OTHER_FILES += tst_card.qml \
    tst_pagestack.qml
