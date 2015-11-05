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

Requires Qt 5.4 or higher.

### Installation

From the root of the repository, run:

    $ qmake
    $ make
    $ make check # Optional, make sure everything is working correctly
    $ sudo make install

Now check out the `demo` folder to see how to use Material Design from QtQuick!

### Material.Extras

The material framework comes with a collection of useful non-UI-related extras in the `Material.Extras` module. This includes a Promises library, date and list utility functions, and an HTTP library based on Promises. Here are some examples of what you can do with these additional components:

Promise:

```qml
import QtQuick 2.3
import Material.Extras 0.1

Item {
    function makePromise() {
        var myvalue = "";

        var promise = new Promises.Promse();
        promise.info.myinfo = "cool info";
        promise.then(function( data, info ) {
                // send data to the next step
                return info.myinfo + " " + data;
        });

        promise.done(function( data, info ) {
                // do something with the data of resolve(...)
        });

        promise.error(function( error, info ) {
                // do something with the data of reject(...)
        });
    }
}
```

### Licensing

QML Material is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

The Material Design icons by Google are released under an [Attribution 4.0 International](http://creativecommons.org/licenses/by/4.0/) license. The icons are directly copied from Google's GitHub repository at https://github.com/google/material-design-icons.

### Papyros Backers

Papyros is supported by the following contributors on our [Bountysource Salt campaign](https://salt.bountysource.com/teams/papyros):

* Hoang Anh
* And several other sponsors listed in the BACKERS.md file
