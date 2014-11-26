#ifndef UNITS_H
#define UNITS_H

#include <QObject>

class Units : public QObject
{
    Q_OBJECT
public:
    explicit Units(QObject *parent = 0);

    Q_INVOKABLE qreal mm(const qreal &number) const;
    Q_INVOKABLE qreal dp(const qreal &number) const;
    Q_INVOKABLE qreal gu(const qreal &number) const;

private:
    qreal m_scale;
};

#endif // UNITS_H
