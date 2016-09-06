TEMPLATE = app

QT += qml quick

SOURCES += main.cpp
RESOURCES += demo.qrc icons/icons.qrc

DEFINES += QPM_INIT\\(E\\)=\"E.addImportPath(QStringLiteral(\\\"qrc:/\\\"));\"
include(../material.pri)
