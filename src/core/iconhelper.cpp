#include "iconhelper.h"

#include <QCoreApplication>
#include <QDebug>
#include <QDir>

#include <QQmlEngine>
#include <QJSEngine>

IconHelper::IconHelper(QObject *parent)
    : QObject(parent)
    , m_useQtResource(false)
    , m_alternativePath(QString())
    , m_applicationPath(qApp->applicationDirPath())
{
#ifdef MATERIAL_ICON_PATH
    m_libraryPath = QString(MATERIAL_ICON_PATH);
#else
    qWarning()<<Q_FUNC_INFO<<"can't find system-wide installation qml-material library path";
    m_libraryPath = QString();
#endif
}

IconHelper::~IconHelper()
{

}

QString IconHelper::parseIcon(const QString &icon)
{
    if (icon.isEmpty())
        return QString();
    if (m_useQtResource) {
        if (!m_alternativePath.isEmpty()) {
            QString tmp = m_alternativePath.toLower();
            if (tmp != m_alternativePath)
                qWarning()<<Q_FUNC_INFO<<"alternativePath should be lower case characters";
            return QString("qrc:/%1/%2").arg(m_alternativePath).arg(icon);
        } else {
            return QString("qrc:/icons/%1").arg(icon);
        }
    } else {
        if (!m_alternativePath.isEmpty()) {
            return QString("%1/%2").arg(m_alternativePath).arg(icon);
        } else {
            return QString("%1/%2").arg(m_libraryPath).arg(icon);
        }
    }
}

bool IconHelper::useQtResource() const
{
    return m_useQtResource;
}

QString IconHelper::alternativePath() const
{
    return m_alternativePath;
}

QString IconHelper::applicationPath() const
{
    return m_applicationPath;
}

void IconHelper::setUseQtResource(bool useQtResource)
{
    m_useQtResource = useQtResource;
}

void IconHelper::setAlternativePath(QString alternativePath)
{
    m_alternativePath = alternativePath;
    QDir dir(m_alternativePath);
    if (!dir.exists())
        qDebug()<<Q_FUNC_INFO<<QString("Can't find icon path [%1], alternativePath should be full application path").arg(m_alternativePath);

}
