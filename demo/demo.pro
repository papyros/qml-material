TEMPLATE = app

QT += qml quick

DEFINES += QPM_INIT
OPTIONS += roboto

include(../material.pri)

SOURCES += main.cpp
RESOURCES += demo.qrc icons/icons.qrc
