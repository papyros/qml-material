#ifndef THEME_H
#define THEME_H

#include <QObject>
#include <QColor>

class Theme : public QObject
{
    Q_OBJECT
    Q_ENUMS(Themes)
    Q_PROPERTY(Themes currentTheme READ currentTheme WRITE setCurrentTheme NOTIFY currentThemeChanged)
    Q_PROPERTY(QColor primaryColor READ primaryColor NOTIFY primaryColorChanged)
    Q_PROPERTY(QColor secondaryColor READ secondaryColor NOTIFY secondaryColorChanged)
public:
    explicit Theme(QObject *parent = 0);

    enum Themes
    {
        LightTheme,
        DarkTheme
    };

    Themes currentTheme() const;
    void setCurrentTheme(const Themes &currentTheme);

    QColor primaryColor() const;
    void setPrimaryColor(const QColor &primaryColor);

    QColor secondaryColor() const;
    void setSecondaryColor(const QColor &secondaryColor);

protected slots:
    void reloadTheme();

signals:
    void currentThemeChanged();
    void primaryColorChanged();
    void secondaryColorChanged();

private:
    Themes m_currentTheme;
    QColor m_primaryColor;
    QColor m_secondaryColor;
};

#endif // THEME_H
