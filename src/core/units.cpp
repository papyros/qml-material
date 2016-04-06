/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

#include "units.h"

#include <QGuiApplication>
#include <QQuickItem>

#if defined(Q_OS_ANDROID)
#include <QtAndroidExtras>
#endif

#define DEFAULT_DPI 72

UnitsAttached::UnitsAttached(QObject *attachee)
        : QObject(attachee), m_screen(nullptr), m_window(nullptr), m_dpi(0), m_multiplier(1)
{
    m_attachee = qobject_cast<QQuickItem *>(attachee);

    if (m_attachee) {
        if (m_attachee->window()) // It might not be assigned to a window yet
            windowChanged(m_attachee->window());
    } else {
        QQuickWindow *window = qobject_cast<QQuickWindow *>(attachee);
        if (window)
            windowChanged(window);
    }

    if (!m_screen)
        screenChanged(QGuiApplication::primaryScreen());
}

void UnitsAttached::windowChanged(QQuickWindow *window)
{
    if (m_window)
        disconnect(m_window, &QQuickWindow::screenChanged, this, &UnitsAttached::screenChanged);

    m_window = window;
    screenChanged(window ? window->screen() : nullptr);

    if (window)
        connect(window, &QQuickWindow::screenChanged, this, &UnitsAttached::screenChanged);
}

void UnitsAttached::screenChanged(QScreen *screen)
{
    if (screen != m_screen) {
        QScreen *oldScreen = m_screen;
        m_screen = screen;

        if (oldScreen)
            oldScreen->disconnect(this);

        if (oldScreen == nullptr || screen == nullptr ||
            screen->physicalDotsPerInch() != oldScreen->physicalDotsPerInch() ||
            screen->logicalDotsPerInch() != oldScreen->logicalDotsPerInch() ||
            screen->devicePixelRatio() != oldScreen->devicePixelRatio()) {
            updateDPI();
            emit dpChanged();
        }
    }
}

int UnitsAttached::dp() const
{
#if QT_VERSION >= QT_VERSION_CHECK(5, 6, 0)
    return m_multiplier;
#else
    auto dp = dpi() / 160;

    return dp > 0 ? dp * m_multiplier : m_multiplier;
#endif
}

int UnitsAttached::dpi() const { return m_dpi; }

qreal UnitsAttached::multiplier() const { return m_multiplier; }

void UnitsAttached::setMultiplier(qreal multiplier)
{
    if (m_multiplier != multiplier) {
        m_multiplier = multiplier;
        emit multiplierChanged();
    }
}

void UnitsAttached::updateDPI()
{
    if (m_screen == nullptr) {
        m_dpi = DEFAULT_DPI;
        return;
    }

#if defined(Q_OS_IOS)
    // iOS integration of scaling (retina, non-retina, 4K) does itself.
    m_dpi = m_screen->physicalDotsPerInch();
#elif defined(Q_OS_ANDROID)
    // https://bugreports.qt-project.org/browse/QTBUG-35701
    // recalculate dpi for Android

    QAndroidJniEnvironment env;
    QAndroidJniObject activity = QtAndroid::androidActivity();
    QAndroidJniObject resources =
            activity.callObjectMethod("getResources", "()Landroid/content/res/Resources;");
    if (env->ExceptionCheck()) {
        env->ExceptionDescribe();
        env->ExceptionClear();

        m_dpi = DEFAULT_DPI;
        return;
    }

    QAndroidJniObject displayMetrics =
            resources.callObjectMethod("getDisplayMetrics", "()Landroid/util/DisplayMetrics;");
    if (env->ExceptionCheck()) {
        env->ExceptionDescribe();
        env->ExceptionClear();

        m_dpi = DEFAULT_DPI;
        return;
    }
    m_dpi = displayMetrics.getField<int>("densityDpi");
    m_multiplier = displayMetrics.getField<float>("density");
#else
    // standard dpi
    m_dpi = m_screen->logicalDotsPerInch() * m_screen->devicePixelRatio();
#endif
}
