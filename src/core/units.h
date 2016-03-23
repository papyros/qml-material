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

public:
    UnitsAttached(QObject* attachee);

    int dp() const;
    int dpi() const;

    void windowChanged(QQuickWindow*);

signals:
    void dpChanged();

protected slots:
    void screenChanged(QScreen*);

private:
    QPointer<QScreen> m_screen;
    QQuickWindow *m_window;
    QQuickItem *m_attachee;
};

class Units : public QObject
{
    Q_OBJECT

public:
    static UnitsAttached *qmlAttachedProperties(QObject *object) {
        return new UnitsAttached(object);
    }
};

QML_DECLARE_TYPEINFO(Units, QML_HAS_ATTACHED_PROPERTIES)

#endif // UNITS_H
