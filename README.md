Material Design implemented in QtQuick
======================================

[![Join the chat at https://gitter.im/papyros/qml-material](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/papyros/qml-material?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![License](https://img.shields.io/badge/license-LGPLv2.1%2B-blue.svg)](http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html)
[![GitHub release](https://img.shields.io/github/release/papyros/qml-material.svg)](https://github.com/papyros/qml-material)
[![Build Status](https://travis-ci.org/papyros/qml-material.svg?branch=develop)](https://travis-ci.org/papyros/qml-material)
[![GitHub issues](https://img.shields.io/github/issues/papyros/qml-material.svg)](https://github.com/papyros/qml-material/issues)
[![Bountysource](https://img.shields.io/bountysource/team/papyros/activity.svg)](https://www.bountysource.com/teams/papyros)

This is a library of QML widgets implementing Google's [Material Design](https://www.google.com/design/spec). It is completely cross platform, and runs on Linux, OS X, and Windows. It may also run on iOS and Android, though those platforms have not been tested and are not currently officially supported.

Brought to you by the [Papyros development team](https://github.com/papyros/qml-material/graphs/contributors).

### Dependencies

 * Qt 5.4 or higher.
 * CMake
 * [Extra CMake Modules](http://api.kde.org/ecm/manual/ecm.7.html)

### Per-project installation using QPM

QPM package coming soon!

Just install using:

    qpm install io.papyros.material

If you want to bundle the Roboto fonts in your project, file **ABOVE** the `include(vendor/vendor.pri)` line, add the following line:

    OPTIONS += roboto

### System-wide installation

From the root of the repository, run:

    mkdir build; cd build
    qmake ..
    make
    make install # use sudo if necessary

Now check out the `demo` folder to see how to use Material Design from QtQuick!

### Licensing

QML Material is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

The Material Design icons by Google are released under an [Attribution 4.0 International](http://creativecommons.org/licenses/by/4.0/) license. The icons are directly copied from Google's GitHub repository at https://github.com/google/material-design-icons.
