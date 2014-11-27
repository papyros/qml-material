TEMPLATE = subdirs

deployment.files += qmldir \
                    *.qml \
                    icons \
                    fonts \
                    ListItems \
                    Transitions

deployment.path = $$[QT_INSTALL_QML]/Material
INSTALLS += deployment

OTHER_FILES += $$deployment.files

mytarget.target = awesome.js
mytarget.commands = ${IN_PWD}/make_awesome.py ${PWD}/fonts/fontawesome/FontAwesome.otf $$mytarget.target
mytarget.CONFIG += no_link target_predeps ignore_no_exist

QMAKE_EXTRA_TARGETS += mytarget