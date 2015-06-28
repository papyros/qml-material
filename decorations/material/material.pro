PLUGIN_TYPE = wayland-decoration-client
load(qt_plugin)

QT += waylandclient-private

OTHER_FILES += \
    material.json \
    main.qml

SOURCES += main.cpp

contains(QT_CONFIG, no-pkg-config) {
    LIBS += -lwayland-client
} else {
    CONFIG += link_pkgconfig
    PKGCONFIG += wayland-client
}
