TEMPLATE = subdirs

deployment.files += qmldir \
                    *.qml \
                    awesome.js \
                    icons \
                    fonts \
                    ListItems \
                    Transitions

deployment.path = $$[QT_INSTALL_QML]/Material
INSTALLS += deployment

OTHER_FILES += $$deployment.files

make_awesome.target = awesome.js
make_awesome.commands = $${PWD}/make_awesome.py $${PWD}/fonts/fontawesome/FontAwesome.otf $$make_awesome.target
make_awesome.CONFIG += no_link target_predeps ignore_no_exist

QMAKE_EXTRA_TARGETS += make_awesome
