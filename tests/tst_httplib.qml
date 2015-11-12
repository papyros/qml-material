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
    name: "HttpTests"

    function test_getgoogle() {

        var html = "";

        var promise = Http.get("http://www.google.com")
            .then( function(data) {
                html = data;
        });

        wait(2000);
        verify( html !== "", "failed to get url");
    }
}
