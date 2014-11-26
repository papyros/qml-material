#ifndef CONTROLS_H
#define CONTROLS_H

#include <QtQml/QQmlExtensionPlugin>

class Controls: public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
    void initializeEngine(QQmlEngine *engine, const char *uri);
};

#endif // CONTROLS_H
