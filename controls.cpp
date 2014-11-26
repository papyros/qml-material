#include "controls.h"
#include "core/units.h"
#include "core/theme.h"

#include <QDebug>
#include <QtQml>

static QObject *UnitsHelperProvider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(scriptEngine)
    return new Units(engine);
}

static QObject *ThemeHelperProvider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(scriptEngine)
    return new Theme(engine);
}

static const struct
{
    const char *type;
    int major, minor;
}
qmldir [] =
{
    { "Action", 1, 0 },
    { "ActionBar", 1, 0 },
    { "Application", 1, 0 },
    { "AwesomeIcon", 1, 0 },
    { "Button", 1, 0 },
    { "Card", 1, 0 },
    { "CardPage", 1, 0 },
    { "Dialog", 1, 0 },
    { "Icon", 1, 0 },
    { "IconAction", 1, 0 },
    { "Ink", 1, 0 },
    { "Label", 1, 0 },
    { "MainView", 1, 0 },
    { "NavigationDrawer", 1, 0 },
    { "Object", 1, 0 },
    { "Page", 1, 0 },
    { "PageApplication", 1, 0 },
    { "PageStack", 1, 0 },
    { "ProgressBar", 1, 0 },
    { "Scrollbar", 1, 0 },
    { "Sidebar", 1, 0 },
    { "Tabs", 1, 0 },
    { "TabView", 1, 0 },
    { "TextField", 1, 0 },
    { "Theme", 1, 0 },
    { "ThinDivider", 1, 0 },
    { "Toolbar", 1, 0 },
    { "View", 1, 0 },
    { "Wave", 1, 0 }
};

void Controls::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("Quantum.Controls"));

    qmlRegisterSingletonType<Units>(uri, 1, 0, "Units", UnitsHelperProvider);
    qmlRegisterSingletonType<Theme>(uri, 1, 0, "Theme", ThemeHelperProvider);

    const QString filesLocation = "qrc:controls";

    for (int i = 0; i < int(sizeof(qmldir)/sizeof(qmldir[0])); i++)
    {
        qmlRegisterType(QUrl(filesLocation + "/" + qmldir[i].type + ".qml"), uri, qmldir[i].major, qmldir[i].minor, qmldir[i].type);
    }
}

void Controls::initializeEngine(QQmlEngine *engine, const char *uri)
{
    QQmlExtensionPlugin::initializeEngine(engine, uri);
}
