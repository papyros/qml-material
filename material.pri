QT += qml quick

HEADERS += src/plugin.h \
           src/core/device.h

SOURCES += src/plugin.cpp \
           src/core/device.cpp

RESOURCES += src/material.qrc \
             src/components/components.qrc \
             src/controls/controls.qrc \
             src/core/core.qrc \
             src/extras/extras.qrc \
             src/listitems/listitems.qrc \
             src/popups/popups.qrc \
             src/styles/styles.qrc \
             src/window/window.qrc

OTHER_FILES = README.md CHANGELOG.md
