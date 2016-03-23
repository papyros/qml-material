QT += qml quick

HEADERS += plugin.h \
           core/device.h \
           core/units.h

SOURCES += plugin.cpp \
           core/device.cpp \
           core/units.cpp

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
