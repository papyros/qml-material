TEMPLATE = subdirs

SUBDIRS += tests

deployment.files += Material

OTHER_FILES += $$deployment.files

deployment.path = $$[QT_INSTALL_QML]/Material
INSTALLS += deployment
