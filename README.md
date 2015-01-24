Material Design implemented in QtQuick
======================================

[![Build Status](https://travis-ci.org/papyros/qml-material.svg?branch=develop)](https://travis-ci.org/papyros/qml-material)

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

QML Extras is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
