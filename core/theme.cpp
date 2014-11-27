#include "core/theme.h"

#include <QDebug>

Theme::Theme(QObject *parent)
    : QObject(parent)
    , m_currentTheme(LightTheme)
{
    reloadTheme();

    connect(this, &Theme::currentThemeChanged, this, &Theme::reloadTheme);
}

Theme::Themes Theme::currentTheme() const
{
    return m_currentTheme;
}

void Theme::setCurrentTheme(const Theme::Themes &currentTheme)
{
    if (m_currentTheme!=currentTheme)
    {
        m_currentTheme = currentTheme;
        emit currentThemeChanged();
    }
}

QColor Theme::primaryColor() const
{
    return m_primaryColor;
}

void Theme::setPrimaryColor(const QColor &primaryColor)
{
    if (m_primaryColor!=primaryColor)
    {
        m_primaryColor = primaryColor;
        emit primaryColorChanged();
    }
}

QColor Theme::secondaryColor() const
{
    return m_secondaryColor;
}

void Theme::setSecondaryColor(const QColor &secondaryColor)
{
    if (m_secondaryColor!=secondaryColor)
    {
        m_secondaryColor = secondaryColor;
        emit secondaryColorChanged();
    }
}

void Theme::reloadTheme()
{
    m_primaryColor = QColor(0,0,0);

    if (m_currentTheme==LightTheme)
        m_secondaryColor = QColor(255,0,0);
    else
        m_secondaryColor = QColor(0,255,0);

    emit primaryColorChanged();
    emit secondaryColorChanged();
}
