/*
 * QML Extras - Extra types and utilities to make QML even more awesome
 *
 * Copyright (C) 2014 Michael Spencer <sonrisesoftware@gmail.com>
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

.pragma library
.import QtQuick 2.4 as QtQuick

function generateID() {
    var guid = (function() {
      function s4() {
        return Math.floor((1 + Math.random()) * 0x10000)
                   .toString(16)
                   .substring(1);
      }
      return function() {
        return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
               s4() + '-' + s4() + s4() + s4();
      };
    })()();
    print(guid);
    return guid;
}

function findRoot(obj) {
    while (obj.parent) {
        obj = obj.parent;
    }

    return obj;
}

function findRootChild(obj, objectName) {
    obj = findRoot(obj);

    var childs = new Array(0);
    childs.push(obj);
    while (childs.length > 0) {
        if (childs[0].objectName == objectName) {
            return childs[0];
        }
        for (var i in childs[0].data) {
            childs.push(childs[0].data[i]);
        }
        childs.splice(0, 1);
    }
    return null;
}


function findChild(obj,objectName) {
    var childs = new Array(0);
    childs.push(obj);
    while (childs.length > 0) {
        if (childs[0].objectName == objectName) {
            return childs[0];
        }
        for (var i in childs[0].data) {
            childs.push(childs[0].data[i]);
        }
        childs.splice(0, 1);
    }
    return null;
}

function escapeHTML(html) {
    return html.replace(/&/g, "&amp;").replace(/>/g, "&gt;").replace(/</g, "&lt;").replace(/"/g, "&quot;");
}

function cherrypick(list, properties) {
    var obj, prop, i;

    if (list instanceof Array) {
        var result = [];

        for (i = 0; i < list.length; i++) {
            var item = list[i];
            obj = {};
            for (var j = 0; j < properties.length; j++) {
                prop = properties[j];
                obj[prop] = item[prop];
            }

            result.push(obj);
        }

        return result;
    } else {
        obj = {};

        for (i = 0; i < properties.length; i++) {
            prop = properties[i];
            print(prop);
            obj[prop] = list[prop];
        }

        return obj;
    }
}

function newObject(path, args, parent) {
    if (!args)
        args = {};

    args.parent = parent;

    var component = Qt.createComponent(path);
    if (component.status === QtQuick.Component.Error) {
        // Error Handling
        print("Unable to load object: " + path + "\n" + component.errorString());
        return null;
    }

    return component.createObject(parent, args);
}

function nth(d) {
    if(d>3 && d<21)
        return 'th'; // thanks kennebec

    switch (d % 10) {
        case 1:  return "st";
        case 2:  return "nd";
        case 3:  return "rd";
        default: return "th";
    }
}
