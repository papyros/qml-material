TARGET = controls
TARGET = $$qtLibraryTarget($$TARGET)

TEMPLATE = lib
DESTDIR = Quantum/Controls

VERSION = 0.0.1 #major.minor.patch

QT += qml quick

CONFIG += plugin c++11

win32 {
    TARGET_EXT = .dll
}

DEFINES += \
    VERSION=\\\"$$VERSION\\\"

INCLUDEPATH += $$PWD

HEADERS += \
    controls.h \
    core/units.h \
    core/theme.h

SOURCES += \
    controls.cpp \
    core/units.cpp \
    core/theme.cpp

OTHER_FILES += \
    qmldir \
    qml/*.qml \
    qml/ListItems/*.qml \
    qml/Transitions/*.qml

RESOURCES += \
    qml/qml.qrc \
    assets/fonts/fonts.qrc \
    assets/icons/icons.qrc

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = $$PWD/qmldir

QMAKE_POST_LINK += $$QMAKE_COPY $$PWD/qmldir $$DESTDIR/qmldir
