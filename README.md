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

 * Qt 5.5 or higher

### Per-project installation using QPM

QPM package coming soon!

Just install using:

    qpm install io.papyros.material

If you want to bundle the Roboto fonts in your project, file **ABOVE** the `include(vendor/vendor.pri)` line, add the following line:

    OPTIONS += roboto

### Per-project installation using git submodules and QMake

Add the submodule:

    git submodule add git@github.com:papyros/qml-material.git material

Add the following DEFINE and `.pri` file to your project:

    DEFINES += QPM_INIT\\(E\\)=\"E.addImportPath(QStringLiteral(\\\"qrc:/\\\"));\"

    include(material/material.pri)

Then, in your `main.cpp` file or wherever you set up a `QQmlApplicationEngine`, call `QPM_INIT` on the engine like this:

    QQmlApplicationEngine engine;
    QPM_INIT(engine)
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

You should then be able to `import Material 0.3` from your QML.

To optionally bundle the Roboto fonts in your project, add this line **ABOVE** the previously added `include()`:

    OPTIONS += roboto

### Per-project installation using git submodules and CMake

Add the submodule:

    git submodule add git@github.com:papyros/qml-material.git material

Add the following lines to your project's `CMakeLists.txt`, and make sure you add `${VENDOR_SOURCES}` to your `add_executable` line:

    add_definitions("-DQPM_INIT\\(E\\)=E.addImportPath\\(QStringLiteral\\(\\\"qrc:/\\\"\\)\\)\\;")

    include(material/vendor.cmake)

Then, in your `main.cpp` file or wherever you set up a `QQmlApplicationEngine`, call `QPM_INIT` on the engine like this:

    QQmlApplicationEngine engine;
    QPM_INIT(engine)
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

You should then be able to `import Material 0.3` from your QML.

Check out [this example](https://github.com/iBeliever/bible-app) of an app using QML Material and CMake if you need further guidance.

### System-wide installation

From the root of the repository, run:

    mkdir build; cd build
    qmake ..
    make
    make install # use sudo if necessary

Now check out the `demo` folder to see how to use Material Design from QtQuick!

### Icons usage

When using the `Icon` component or the `iconName` property, qml-material looks for icons in the form of `qrc:/icons/<category>/<name>.svg`. Only a core set of icons used by qml-material icons are actually bundled with qml-material. To use icons in your own programs, you can either manually create a qrc file, or you can create `icons.yml` file and use the `icons.py` script from qml-material.

To use the `icons.py` script, create a file called `icons.yml` that looks like this:

    icons:
      - action/settings
      - alert/warning
      - ...

Run `icons.py`, located in the `scripts` folder of the repository. This will download the latest version of all the icons listed in this file, storing them in a folder called `icons`. It also generates a resource file called `icons/icons.qrc`, which you should add to your QMake or CMake project.

Now whenever you add icons to the `icons.yml` file, just rerun `icons.py` and the new icons will be downloaded. To update your icons, just delete the `icons` folder and rerun `icons.py`.

### Licensing

QML Material is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

The Material Design icons by Google are released under an [Attribution 4.0 International](http://creativecommons.org/licenses/by/4.0/) license. The icons are directly copied from Google's GitHub repository at https://github.com/google/material-design-icons.
