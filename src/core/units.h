/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

#ifndef UNITS_H
#define UNITS_H

#include <QObject>

#include <QScreen>
#include <QQuickWindow>
#include <QPointer>

class UnitsAttached : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int dp READ dp NOTIFY dpChanged)
    Q_PROPERTY(qreal multiplier READ multiplier WRITE setMultiplier NOTIFY multiplierChanged)

public:
    UnitsAttached(QObject *attachee);

    int dp() const;
    int dpi() const;
    qreal multiplier() const;

public slots:
    void setMultiplier(qreal multiplier);

signals:
    void dpChanged();
    void multiplierChanged();

protected slots:
    void screenChanged(QScreen *);

private:
    void updateDPI();
    void windowChanged(QQuickWindow *);

    QPointer<QScreen> m_screen;
    QQuickWindow *m_window;
    QQuickItem *m_attachee;

    int m_dpi;
    qreal m_multiplier;
};

class Units : public QObject
{
    Q_OBJECT

public:
    static UnitsAttached *qmlAttachedProperties(QObject *object)
    {
        return new UnitsAttached(object);
    }
};

QML_DECLARE_TYPEINFO(Units, QML_HAS_ATTACHED_PROPERTIES)

#endif // UNITS_H
