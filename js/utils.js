/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2014 Michael Spencer
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

function newObject(path, args, parent) {
    var componentArguments = (args === undefined || args === null) ? {} : args
    var componentParent = (parent === undefined || parent === null) ? null : parent
    var component = Qt.createComponent(path);

    if (component.status == Component.Error) {
        throw("Unable to load object: %1:'%2'"
            .arg(path)
            .arg(component.errorString()));
    }

    return component.createObject(componentParent, componentArguments);
}
