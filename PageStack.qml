import QtQuick 2.0
import "../qml-extras/utils.js" as Utils

Item {
    id: pageStack
    clip: true

    property var stack: []
    property Page currentPage
    property var currentTabs: currentPage && currentPage.hasOwnProperty("tabs") ? currentPage.tabs : []

    property int count: stack.length

    signal pagePushed(var newPage, var oldPage)
    signal pagePopped(var previousPage, var currentPage)

    function open(page, caller, args) {
        print(typeof(page))
        if (typeof(page) == "string") {
            page = Utils.newObject(page, args, app)
            if (page === null)
                return
            page.dynamic = true
        } else if (String(page).indexOf("QQmlComponent") == 0) {
            page = page.createObject(app, args);
            if (page === null)
                return
            page.dynamic = true
        }

        page.open(caller)
    }

    function pushFrom(caller, page, args) {
        page = objectify(page, args)

        page.z = !currentPage ? 0 : stack.length + 1

        pagePushed(page, currentPage)

        if (currentPage) {
            stack.push(currentPage)
            stack = stack
        }

        if (stack.length == 0)
            page.showBackButton = false

        currentPage = page

        if (!page.transition)
            page.transition = Utils.newObject(Qt.resolvedUrl('Transitions/PageTransition.qml'))

        if (caller)
            page.transition.transitionTo(caller, page)
        else
            page.transition.transitionTo(page)
    }

    function push(page, args) {
        pushFrom(undefined, page, args)
    }

    function pop() {
        currentPage.transition.transitionBack()

        pagePopped(stack[stack.length - 1], currentPage)

        currentPage = stack.pop()
        stack = stack
    }

    function objectify(page, args) {
        print(typeof(page), page)
        if (typeof(page) == "string") {
            page = Utils.newObject(page, args, pageStack)
            if (page === null)
                return
            page.dynamic = true
        } else if (String(page).indexOf("QQmlComponent") == 0) {
            page = page.createObject(app, args);
            if (page === null)
                return
            page.dynamic = true
        }

        return page
    }

    property Page initialPage

    Component.onCompleted: push(initialPage)
}
