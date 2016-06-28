TEMPLATE = app

QT += qml quick

SOURCES += main.cpp
RESOURCES += demo.qrc icons/icons.qrc

# Include qml-material
OPTIONS += roboto
DEFINES += QPM_INIT
include(../material.pri)
