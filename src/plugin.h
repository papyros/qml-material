/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

#ifndef MATERIAL_PLUGIN_H
#define MATERIAL_PLUGIN_H

#include <QQmlExtensionPlugin>

class MaterialPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "io.papyros.Material")

public:
    void registerTypes(const char *uri);
};

#endif // MATERIAL_PLUGIN_H
