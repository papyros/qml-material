#include "core/units.h"

#include <QScreen>
#include <QDebug>

Units::Units(QObject *parent)
    : QObject(parent)
    , m_scale(1)
{
    m_scale = 6; // TODO
}

qreal Units::mm(const qreal &number) const
{
    return number * m_scale;
}

qreal Units::dp(const qreal &number) const
{
    return number * m_scale * 0.15;
}

qreal Units::gu(const qreal &number) const
{
    return dp(number * 8);
}
