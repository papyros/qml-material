TEMPLATE = subdirs

deployment.files += qmldir \
                    *.qml

deployment.path = $$[QT_INSTALL_QML]/QtQuick/Controls/Styles/Material
INSTALLS += deployment

OTHER_FILES += $$deployment.files
