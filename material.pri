CONFIG += c++11
QT += qml quick

android {
    QT += androidextras svg xml
}

HEADERS += $$PWD/src/plugin.h \
           $$PWD/src/core/device.h \
           $$PWD/src/core/units.h \
           $$PWD/src/core/iconhelper.h

SOURCES += $$PWD/src/plugin.cpp \
           $$PWD/src/core/device.cpp \
           $$PWD/src/core/units.cpp \
           $$PWD/src/core/iconhelper.cpp

RESOURCES += $$PWD/src/material.qrc \
             $$PWD/src/components/components.qrc \
             $$PWD/src/controls/controls.qrc \
             $$PWD/src/core/core.qrc \
             $$PWD/src/extras/extras.qrc \
             $$PWD/src/listitems/listitems.qrc \
             $$PWD/src/popups/popups.qrc \
             $$PWD/src/styles/styles.qrc \
             $$PWD/src/window/window.qrc \
             $$PWD/icons/core_icons.qrc

OTHER_FILES = $$PWD/README.md $$PWD/CHANGELOG.md

contains(OPTIONS, roboto) {
    RESOURCES += $$PWD/fonts/fonts.qrc
}
