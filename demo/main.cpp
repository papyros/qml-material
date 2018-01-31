#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <plugin.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    MaterialPlugin plugin;
    plugin.registerTypes("Material");

    QQmlApplicationEngine engine;
    QPM_INIT(engine);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
