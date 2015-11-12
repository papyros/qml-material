/*
* QML Extras - Extra types and utilities to make QML even more awesome
*
* Copyright (C) 2014 geiseri
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
import QtTest 1.0
import Material.Extras 0.1

TestCase {
    name: "PromiseTests"

    function test_createpromise() {
        var promise = new Promises.Promise();
        verify((promise !== undefined), "could not create");
        verify((promise !== null), "could not create");
        promise.info.test1 = "test1";
        compare(promise.info.test1, "test1", "promise populated");
    }

    function test_createpromises() {
        var promise1 = new Promises.Promise();
        var promise2 = new Promises.Promise();

        promise1.info.test = "test1";
        promise2.info.test = "test2"
        compare(promise1.info.test, "test1", "promise valid");
        compare(promise2.info.test, "test2", "promise valid");
    }
}
