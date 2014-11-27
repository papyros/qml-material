TEMPLATE = subdirs

deployment.files += qmldir \
                    *.qml \
                    icons \
                    fonts \
                    ListItems \
                    Transitions 

deployment.path = $$[QT_INSTALL_QML]/Material
INSTALLS += deployment
