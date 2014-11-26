TEMPLATE = subdirs

deployment.files += qmldir \
                    *.qml \
                    js \
                    icons \
                    fonts \
                    ListItems \
                    Transitions 

deployment.path = $$[QT_INSTALL_QML]/Material
INSTALLS += deployment
