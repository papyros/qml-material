TEMPLATE = lib
CONFIG += plugin
QT += qml quick svg

TARGET  = materialiconprovider

SOURCES += materialiconprovider.cpp

target.path = $$[QT_INSTALL_QML]/Material
INSTALLS = target
