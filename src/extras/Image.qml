/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2014 Bogdan Cuza <bogdan.cuza@hotmail.com>
 *               2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4

Image {
  id: image

  property color averageColor

  Canvas {
    id: canvas

    opacity: 0

    onAvailableChanged: {
      var imgSource = image.source;
      canvas.loadImage(String(imgSource));
      var context = canvas.getContext("2d"),
      pixelInterval = 5,
      count = 0,
      i = -4,
      rgba = {"r": 0, "g": 0, "b": 0, "a": 0},
      data = context.createImageData(String(imgSource)).data,
      length = data.length;
      while ((i += pixelInterval * 4) < length) {
        count++;
        rgba.r += data[i];
        rgba.g += data[i+1];
        rgba.b += data[i+2];
        rgba.a += data[i+3];
      };
      rgba.r = Math.floor(rgba.r/count);
      rgba.g = Math.floor(rgba.g/count);
      rgba.b = Math.floor(rgba.b/count);
      rgba.a = Math.floor(rgba.a/count);
      image.averageColor = Qt.rgba(rgba.r/255, rgba.g/255, rgba.b/255, rgba.a/255);
    }
  }
}
