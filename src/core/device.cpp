/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

#include "device.h"

Device::Device(QObject *parent)
        : QObject(parent)
{
    QGuiApplication *app = (QGuiApplication *) QGuiApplication::instance();
    m_screen = app->primaryScreen();

    connect(app, &QGuiApplication::primaryScreenChanged,
            this, &Device::screenChanged);
}

QObject *Device::qmlSingleton(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    return new Device();
}

Device::FormFactor Device::formFactor() const
{
    float diagonal = calculateDiagonal();

    if (diagonal >= 3.5 && diagonal < 5) { //iPhone 1st generation to phablet
        return Device::Phone;
    } else if (diagonal >= 5 && diagonal < 6.5) {
        return Device::Phablet;
    } else if (diagonal >= 6.5 && diagonal < 10.1) {
        return Device::Tablet;
    } else if (diagonal >= 10.1 && diagonal < 29) {
        return Device::Computer;
    } else if (diagonal >= 29 && diagonal < 92) {
        return Device::TV;
    } else {
        return Device::Unknown;
    }
}

QString Device::name() const
{
    switch (formFactor()) {
        case Phone:
            return tr("phone");
        case Phablet:
            return tr("phablet");
        case Tablet:
            return tr("tablet");
        case Computer:
            return tr("computer");
        case TV:
            return tr("TV");
        case Unknown:
            return tr("device");
    }
}

QString Device::iconName() const
{
    switch (formFactor()) {
        case Phone:
            return "hardware/smartphone";
        case Phablet:
            return "hardware/tablet";
        case Tablet:
            return "hardware/tablet";
        case Computer:
            return "hardware/desktop_windows";
        case TV:
            return "hardware/tv";
        case Unknown:
            return "hardware/computer";
    }
}

bool Device::hasTouchScreen() const
{
// QTBUG-36007
#if defined(Q_OS_ANDROID)
    return true;
#else
    const auto devices = QTouchDevice::devices();
    for (const QTouchDevice *dev : devices)
        if (dev->type() == QTouchDevice::TouchScreen)
            return true;
    return false;
#endif
}

bool Device::isMobile() const
{
#if defined(Q_OS_IOS) || defined(Q_OS_ANDROID) || defined(Q_OS_BLACKBERRY) || defined(Q_OS_QNX) || defined(Q_OS_WINRT)
    return true;
#else
    if (qEnvironmentVariableIsSet("QT_QUICK_CONTROLS_MOBILE")) {
        return true;
    }
    return false;
#endif
}

bool Device::hoverEnabled() const
{
    return !isMobile() || !hasTouchScreen();
}

void Device::screenChanged()
{
    if (m_screen)
        m_screen->disconnect(this);

    QGuiApplication *app = (QGuiApplication *) QGuiApplication::instance();
    m_screen = app->primaryScreen();

    connect(m_screen, &QScreen::geometryChanged, this, &Device::geometryChanged);

    geometryChanged();
}

void Device::geometryChanged()
{
    emit formFactorChanged();
    emit nameChanged();
    emit iconNameChanged();
}

float Device::calculateDiagonal() const
{
    return sqrt(pow((m_screen->physicalSize().width()), 2) +
                pow((m_screen->physicalSize().height()), 2)) * 0.039370;
}
