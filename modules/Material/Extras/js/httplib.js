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
.import "promises.js" as Promises

function post(path, args, timeout) {
    return request(path, "POST", args, timeout);
}

function patch(path, args, timeout) {
    return request(path, "POST", args, timeout);
}

function put(path, args, timeout) {
    return request(path, "PUT", args, timeout);
}

//function delete(path, options, args) {
//    request(path, "DELETE", options, args)
//}

function get(path, args, timeout) {
    return request(path, "GET", args, timeout);
}

function request(path, call, args, timeout) {
    var address = path;

    if (!args) args = {};

    var options = args.options ? args.options : [];
    var headers = args.headers ? args.headers : {};
    var body = args.body ? args.body : undefined;

    if (options.length > 0)
        address += (address.indexOf('?') == -1 ? "?" : "&") + options.join("&").replace(/ /g, "%20");

    print(call, address, body);
    print("Headers", JSON.stringify(headers));

    var promise = new Promises.Promise();
    var doc = new XMLHttpRequest();
    var timer;

    if(timeout !== undefined) {
        console.log("Creating timer.");
        timer = Qt.createQmlObject("import QtQuick 2.4; Timer {interval: " + timeout + "; repeat: false; running: true;}", Qt.application, "XHRTimer");
        timer.triggered.connect(function() {
            doc.hasTimeout = true;
            doc.abort();
        });
    }

    doc.onreadystatechange = function() {
        if (doc.readyState === XMLHttpRequest.DONE) {
            //print(doc.getResponseHeader("X-RateLimit-Remaining"))

            //print(doc.responseText)

            if (timer) {
                console.log("Destroing timer.");
                timer.destroy();
                timer = undefined;
            }

            var responseArray = doc.getAllResponseHeaders().split('\n');
            var responseHeaders = {};

            for (var i = 0; i < responseArray.length; i++) {
                var header = responseArray[i];
                var items = split(header, ':', 1);
                responseHeaders[items[0]] = items[1];
            }

            //print("Status:",doc.status, "for call", call, address, headers['If-None-Match'], responseHeaders['etag'])

            promise.info.headers = responseHeaders;
            promise.info.status = doc.status;

            if (doc.status == 200 || doc.status == 201 || doc.status == 202 || doc.status === 304) {
                print("Calling back with no error...");
                promise.resolve(doc.responseText);
            } else {
                print("Calling back with error...");
                var error = doc.responseText;
                if (doc.hasTimeout) {
                    error = "Connection timeout.";
                }
                promise.reject(error);
            }
        }
    };

    doc.open(call, address, true);
    for (var key in headers) {
        //print(key + ": " + headers[key])
        doc.setRequestHeader(key, headers[key]);
    }

    if (body)
        doc.send(body);
    else
        doc.send();

    return promise;
}

function split(string, sep, limit) {
    var array = [];
    for (var i = 0; i < limit; i++) {
        var index = string.indexOf(sep);
        if (index === -1) {
            array.push(string);
            string = undefined;
            break;
        } else {
            array.push(string.substring(0, index));
            string = string.substring(index+1);
        }
    }

    if (string !== undefined)
        array.push(string.trim());

    return array;
}
