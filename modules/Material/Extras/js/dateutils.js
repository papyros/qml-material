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

var today = new Date();
today.setHours(0);
today.setMinutes(0);
today.setSeconds(0);
today.setMilliseconds(0);

function formattedDate(date) {
    if (isToday(date)) {
        return "Today (%1)".arg(dayOfWeek(date));
    } else if (isTomorrow(date)) {
        return "Tomorrow (%1)".arg(dayOfWeek(date));
    } else {
        return date.toLocaleDateString(Qt.locale());
    }
}

function dayOfWeek(date) {
    return Qt.formatDate(date, "dddd");
}

function setDayOfWeek(date, day) {
    var currentDay = date.getDay();
    var distance = day - currentDay;
    date.setDate(date.getDate() + distance);
}

function dayOfWeekIndex(date) {
    if (!date)
        date = new Date();

    var list = [];
    for (var i = 0; i < 7; i++) {
        list.push(Qt.locale().dayName(i));
    }
    var day = Qt.formatDate(date, "dddd");
    return list.indexOf(day);
}

function isToday(date) {
    var today = new Date();

    return datesEqual(date, today);
}

function isTomorrow(date) {
    var today = new Date();
    today.setDate(today.getDate() + 1);

    return datesEqual(date, today);
}

function isThisWeek(date) {
    var endOfWeek = new Date();
    setDayOfWeek(endOfWeek, 6);

    return dateIsBeforeOrSame(date, endOfWeek);
}

function datesEqual(date1, date2) {
    return date1.getFullYear() === date2.getFullYear() &&
            date1.getMonth() === date2.getMonth() &&
            date1.getDate() === date2.getDate();
}

function dateIsBefore(date1, date2) {
    /* jshint laxbreak: true */
    var ans = date1.getFullYear() < date2.getFullYear() ||
            (date1.getFullYear() === date2.getFullYear() && date1.getMonth() < date2.getMonth()) ||
            (date1.getFullYear() === date2.getFullYear() && date1.getMonth() === date2.getMonth() &&
             date1.getDate() < date2.getDate());
    return ans;
}

function dateIsBeforeOrSame(date1, date2) {
    var ans = date1.getFullYear() < date2.getFullYear() ||
            (date1.getFullYear() === date2.getFullYear() && date1.getMonth() < date2.getMonth()) ||
            (date1.getFullYear() === date2.getFullYear() && date1.getMonth() === date2.getMonth() &&
             date1.getDate() <= date2.getDate());
    return ans;
}

function dateIsThisWeek(date) {
    var end = new Date();
    end.setDate(end.getDate() + 7);
    return dateIsBefore(date, end);
}

function friendlyTime(time, standalone) {
    var now = new Date();
    time = new Date(time);
    var seconds = (now - time)/1000;
    //print("Difference:", now, time, now - time)
    var minutes = Math.round(seconds/60);
    if (minutes < 1)
        return standalone ? ("Now") : "now";
    else if (minutes == 1)
        return ("1 minute ago");
    else if (minutes < 60)
        return ("%1 minutes ago").arg(minutes);
    var hours = Math.round(minutes/60);
    if (hours == 1)
        return ("1 hour ago");
    else if (hours < 24)
        return ("%1 hours ago").arg(hours);
    var days = Math.round(hours/24);
    if (days == 1)
        return ("1 day ago");
    else if (days <= 10)
        return ("%1 days ago").arg(days);
    return standalone ? Qt.formatDate(time) : ("on %1").arg(Qt.formatDate(time));
}

function pad(n, width, z) {
    z = z || '0';
    n = n + '';
    return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
}

function shortDuration(duration, type) {
    var hours = Math.floor(duration/(1000 * 60 * 60));
    var minutes = Math.floor(duration/(1000 * 60) - 60 * hours);
    var seconds = Math.floor(duration/1000 - 60 * minutes - 60 * 60 * hours);

    if (type === undefined)
        type = '?';

    var str = '';
    if (type === 's' || type === '?')
        str = "%1".arg(pad(seconds, 2));
    if (type === 's' || type === 'm' || (type === '?' && (minutes >= 1 || hours >= 1))) {
        if (str.length > 0)
            str = "%1:%2".arg(pad(minutes, 2)).arg(str);
        else
            str = "%1".arg(pad(minutes, 2));
    }
    if (type === 's' || type === 'm' || type === 'h' || (type === '?' && hours >= 1)) {
        if (str.length > 0)
            str = "%1:%2".arg(hours).arg(str);
        else
            str = "%1".arg(hours);
    }
    return str.trim();
}

function friendlyDuration(duration, type) {
    var hours = Math.floor(duration/(1000 * 60 * 60));
    var minutes = Math.floor(duration/(1000 * 60) - 60 * hours);
    var seconds = Math.floor(duration/1000 - 60 * minutes - 60 * 60 * hours);

    if (type === undefined)
        type = '?';

    var str = '';
    if (type === 's' || type === '?')
        str = "%1s".arg(seconds);
    if (type === 's' || type === 'm' || (type === '?' && (minutes >= 1 || hours >= 1)))
        str = "%1m %2".arg(minutes).arg(str);
    if (type === 's' || type === 'm' || type === 'h' || (type === '?' && hours >= 1))
        str = "%1h %2".arg(hours).arg(str);
    return str.trim();
}

function parseDuration(str) {
    var days = str.match(/(\d+)\s*d/);
    var hours = str.match(/(\d+)\s*h/);
    var minutes = str.match(/(\d+)\s*m/);
    var seconds = str.match(/(\d+)\s*s/);
    var time = 0;
    if (days)
        time += parseInt(days[1]) * 86400;
    if (hours)
        time += parseInt(hours[1]) * 3600;
    if (minutes)
        time += parseInt(minutes[1]) * 60;
    if (seconds)
        time += parseInt(seconds[1]);
    return time * 1000;
}

function daysUntilDate(date) {
    return Math.floor((new Date(date) - new Date())/(1000*60*60*24));
}

function toUTC(date) {
    return new Date(date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate(), date.getUTCHours(), date.getUTCMinutes(), date.getUTCSeconds());
}

function timeFromDate(date) {
    print(date.getSeconds(),date.getMinutes() * 60,date.getHours() * 3600);
    return 1000 * (date.getSeconds() + date.getMinutes() * 60 + date.getHours() * 3600);
}

function isValid(date) {
    return date.toString() != "Invalid Date";
}
