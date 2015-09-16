TEMPLATE = subdirs

deployment.files += qmldir \
                    *.qml \
                    images \
                    js

deployment.path = $$[QT_INSTALL_QML]/Material/Extras
INSTALLS += deployment
