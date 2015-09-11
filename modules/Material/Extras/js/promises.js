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

function subclass(constructor, superConstructor) {
    function surrogateConstructor() {}

    surrogateConstructor.prototype = superConstructor.prototype;

    var prototypeObject = new surrogateConstructor();
    prototypeObject.constructor = constructor;

    constructor.prototype = prototypeObject;
}


// Promise class

function Promise(delayed) {
    this.thenHandlers = [];
    this.onDone = [];
    this.onError = [];
    this.info = {};

    if (delayed !== undefined)
        this.code = delayed;
}

Promise.prototype.then = function (handler) {
    this.thenHandlers.push(handler);
    return this;
};

Promise.prototype.done = function (onResolved) {
    this.onDone.push(onResolved);
    return this;
};

Promise.prototype.error = function (onError) {
    this.onError.push(onError);
    return this;
};

Promise.prototype.resolve = function (value) {
    var handler, i;
    //print("Success")
    for (i = 0; i < this.thenHandlers.length; i++) {
        handler = this.thenHandlers[i];
        value = handler(value, this.info);
    }

    for (i = 0; i < this.onDone.length; i++) {
        handler = this.onDone[i];
        handler(value, this.info);
    }
};

Promise.prototype.reject = function (error) {
    //print("Failure", error)
    for (var i = 0; i < this.onError.length; i++) {
        var handler = this.onError[i];
        handler(error, this.info);
    }
};

Promise.prototype.start = function(args) {
    this.code(args);
};

// JoinedPromise class

subclass(JoinedPromise, Promise);

function JoinedPromise() {
    Promise.call(this);

    this.promiseCount = 0;
}

JoinedPromise.prototype.add = function(promise) {
    this.promiseCount++;

    var join = this;

    promise.done(function(data) {
        join.promiseCount--;

        if (join.promiseCount === 0) {
            print("All joined promises done!");
            join.resolve();
        }
    });

    promise.error(function (error) {
        join.promiseCount = -1;

        print("A joined promise failed, shortcutting to failure!");
        join.reject(error);
    });

    return this;
};
