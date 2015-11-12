/*
 * QML Extras - Extra types and utilities to make QML even more awesome
 *
 * Copyright (C) 2014 Bogdan Cuza
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 2.1 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
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
