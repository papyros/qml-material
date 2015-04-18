Material Design implemented in QtQuick
======================================

[![Join the chat at https://gitter.im/papyros/qml-material](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/papyros/qml-material?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![License](https://img.shields.io/badge/license-LGPLv2.1%2B-blue.svg)](https://img.shields.io/badge/license-LGPL%203%2B-blue.svg)
[![GitHub release](https://img.shields.io/github/release/papyros/qml-material.svg)](https://github.com/papyros/qml-material)
[![Build Status](https://travis-ci.org/papyros/qml-material.svg?branch=develop)](https://travis-ci.org/papyros/qml-material)
[![GitHub issues](https://img.shields.io/github/issues/papyros/qml-material.svg)](https://github.com/papyros/qml-material/issues)
[![Bountysource](https://img.shields.io/bountysource/team/papyros/activity.svg)](https://www.bountysource.com/teams/papyros)

This is a library of QML widgets implementing Google's [Material Design](https://www.google.com/design/spec). It is completely cross platform, and runs on Linux, OS X, and Windows. It may also run on iOS and Android, though those platforms have not been tested and are not currently officially supported.

Brought to you by the [Papyros development team](https://github.com/papyros/qml-material/graphs/contributors).

### Dependencies

Requires Qt 5.3 or higher and [QML Extras](https://github.com/papyros/qml-extras) installed as QML module.

### Installation

From the root of the repository, run:

    $ qmake
    $ make
    $ make check # Optional, make sure everything is working correctly
    $ sudo make install

Now checkout out the `examples` folder to see how to use Material Design from QtQuick!

### Licensing

QML Material is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
