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
    name: "Document Tests"

    Document {
        id: doc
    }

    Document {
        id: changingDoc
    }

    SignalSpy {
        id: dataChangedSpy
        target: changingDoc
        signalName: "dataChanged"
    }

    function referenceObject()
    {
        return {
            version : 1,
            Element1 : 'StringValue',
            Element2 : 12
        }
    }

    function referenceString()
    {
        return JSON.stringify( referenceObject() );
    }

    function referenceJson()
    {
        return JSON.parse( referenceString() );
    }

    function test_loaddocument() {
        doc.fromJSON(referenceJson());

        compare( doc.get('Element1'), 'StringValue', "Document value doesn't match" )
    }

    function test_savedocument() {
        doc.set('Element1', 'StringValue');
        doc.set('Element2', 2);

        compare( doc.toJSON().Element1 , 'StringValue', "Document content doesn't match" )
    }

    function test_datachanged() {
        changingDoc.set('Element1',5 );

        dataChangedSpy.wait()
        compare(dataChangedSpy.count, 2, "Document change did not fire");
        compare(changingDoc.get('Element1'),5, "Document content doesn't match");

        changingDoc.set('Element1',5);
        dataChangedSpy.wait()
        compare(dataChangedSpy.count, 2, "Document was not supposed to change");

        changingDoc.set('Element1',10);
        dataChangedSpy.wait()
        compare(dataChangedSpy.count, 3, "Document change did not fire");
    }


}
