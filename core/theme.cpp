#include "core/theme.h"

Theme::Theme(QObject *parent)
    : QObject(parent)
{
}

QColor Theme::fontColor(const Theme::FontColor &color) const
{
    switch(color)
    {
    case TextColor:
        return QColor(0,0,0,200);
    case TestColor:
        return QColor(255,0,0);
    case DefaultColor:
    default:
        return QColor(0,0,0);
    }

    return QColor(0,0,0);
}

QColor Theme::backgroundColor(const Theme::BackgroundColor &color) const
{
    switch(color)
    {
    case SecondaryColor:
        return QColor(0, 0, 0, 122);
    default:
        return QColor(0, 0, 0);
    }

    return QColor(0, 0, 0);
}
