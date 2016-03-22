QT += qml quick

HEADERS += $$PWD/src/plugin.h \
           $$PWD/src/core/device.h

SOURCES += $$PWD/src/plugin.cpp \
           $$PWD/src/core/device.cpp

RESOURCES += $$PWD/src/material.qrc \
             $$PWD/src/components/components.qrc \
             $$PWD/src/controls/controls.qrc \
             $$PWD/src/core/core.qrc \
             $$PWD/src/extras/extras.qrc \
             $$PWD/src/listitems/listitems.qrc \
             $$PWD/src/popups/popups.qrc \
             $$PWD/src/styles/styles.qrc \
             $$PWD/src/window/window.qrc \
             $$PWD/icons/icons.qrc

OTHER_FILES = $$PWD/README.md $$PWD/CHANGELOG.md
