QT += qml quick

HEADERS += src/plugin.h \
           src/core/device.h

SOURCES += src/plugin.cpp \
           src/core/device.cpp

RESOURCES += src/material.qrc

OTHER_FILES = README.md CHANGELOG.md
