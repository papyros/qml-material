#ifndef ICONHELPER_H
#define ICONHELPER_H

#include <QObject>

class QQmlEngine;
class QJSEngine;
class IconHelper : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool useQtResource READ useQtResource WRITE setUseQtResource)
    Q_PROPERTY(QString alternativePath READ alternativePath WRITE setAlternativePath)
    Q_PROPERTY(QString applicationPath READ applicationPath CONSTANT)

public:
    explicit IconHelper(QObject *parent = 0);
    virtual ~IconHelper();

    ///
    /// \brief parseIcon
    /// \param icon the iconname
    /// \return
    ///
    Q_INVOKABLE QString parseIcon(const QString &icon);

    bool useQtResource() const;
    QString alternativePath() const;
    QString applicationPath() const;

public slots:
    void setUseQtResource(bool useQtResource);
    void setAlternativePath(QString alternativePath);

private:
    bool m_useQtResource;
    QString m_alternativePath;
    QString m_applicationPath;
    QString m_libraryPath;
};


#endif // ICONHELPER_H
