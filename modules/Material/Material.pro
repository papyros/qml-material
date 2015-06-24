TEMPLATE = subdirs

deployment.files += qmldir \
                    *.qml \
                    awesome.js \
                    icons \
                    fonts \
                    ListItems \
                    Tiles \
                    Transitions

deployment.path = $$[QT_INSTALL_QML]/Material
INSTALLS += deployment

OTHER_FILES += $$deployment.files
