/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

#include "plugin.h"

#include <QtQml>

#include "core/device.h"
#include "core/units.h"

class MaterialRegisterHelper {

public:
    MaterialRegisterHelper(const char *uri) {
        qmlRegisterSingletonType<Device>(uri, 0, 1, "Device", Device::qmlSingleton);
        qmlRegisterUncreatableType<Units>(uri, 0, 3, "Units", QStringLiteral("Units can only be used via the attached property."));
    }
};

void MaterialPlugin::registerTypes(const char *uri)
{
    // @uri Material
    Q_ASSERT(uri == QStringLiteral("Material"));

    MaterialRegisterHelper helper(uri);
}

// When using QPM, the C++ plugin is not used and the QML types must be registered manually
#ifdef QPM_INIT
    static MaterialRegisterHelper registerHelper("Material");
#endif
