/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 2.1 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef STYLE_H
#define STYLE_H

#include <QObject>
#include <QColor>
#include <qqml.h>

class PlatformStyle : public QObject
{
    Q_OBJECT

public:
    PlatformStyle(QObject *parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE virtual QColor decorationColor() { return QColor(); };

    static QObject *qmlSingleton(QQmlEngine *engine, QJSEngine *scriptEngine);
};

#endif // STYLE_H
