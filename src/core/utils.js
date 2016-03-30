/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2014-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

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

function filter(list, filter) {
    var filtered = [];

    forEach(list, function(item) {
        if (filter(item))
            filtered.push(item)
    })

    return filtered;
}

function forEach(list, callback) {
    for (var i = 0; i < length(list); i++) {
        var item = getItem(list, i)
        callback(item)
    }
}

function getItem(model, index) {
    var item = model.get ? model.get(index) : model[index]

    if (model.get && item.modelData)
        item = item.modelData

    return item
}

function length(model) {
    if (model === undefined || model === null)
        return 0
    else
        return model.count ? model.count : model.length
}
