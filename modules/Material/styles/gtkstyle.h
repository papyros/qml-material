/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 2.1 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef GTK_STYLE_H
#define GTK_STYLE_H

#include "style.h"

#include <QLibrary>
#include <QDebug>
#include <QHash>
#include <QCoreApplication>

#undef signals
extern "C" {
#include <gtk/gtk.h>
}
#define signals Q_SIGNALS

#define Q_GTK_IS_WIDGET(widget)                                                                    \
    (widget != nullptr && G_TYPE_CHECK_INSTANCE_TYPE((widget), gtk_widget_get_type()) == 1)

typedef GtkStyle *(*Ptr_gtk_widget_get_style)(GtkWidget *);
typedef GtkWidget *(*Ptr_gtk_menu_bar_new)(void);

class GtkPlatformStyle : public PlatformStyle
{
    Q_OBJECT

public:
    GtkPlatformStyle(QObject *parent = nullptr) : PlatformStyle(parent)
    {
        qDebug() << "Initializing";
        QLibrary libgtk(QStringLiteral("gtk-x11-2.0"), 0, 0);

        gtk_init(NULL, NULL);

        qDebug() << "Initialized";

        GtkWidget *gtkWindow = gtk_window_new(GTK_WINDOW_POPUP);
        gtk_widget_realize(gtkWindow);
        removeWidgetFromMap("GtkWindow");
        gtkWidgetMap()->insert("GtkWindow", gtkWindow);

        gtk_menu_bar_new = (Ptr_gtk_menu_bar_new) libgtk.resolve("gtk_menu_bar_new");
        gtk_widget_get_style = (Ptr_gtk_widget_get_style) libgtk.resolve("gtk_widget_get_style");

        GtkWidget *gtkMenuBar = gtk_menu_bar_new();
        qDebug() << "Gtk widget" << gtk_widget_get_name(gtkMenuBar);
        setupGtkWidget(gtkMenuBar);
        addAllSubWidgets(gtkMenuBar, NULL);
    }

    Q_INVOKABLE virtual QColor decorationColor() override
    {
        GtkWidget *gtkMenubar = gtkWidget("GtkMenuBar");
        qDebug() << gtk_widget_get_name(gtkMenubar);
        GdkColor gdkBg = gtk_widget_get_style(gtkMenubar)
                                 ->bg[GTK_STATE_NORMAL]; // Theme can depend on transparency

        qDebug() << (gdkBg.red >> 8) << (gdkBg.green >> 8) << (gdkBg.blue >> 8);

        return QColor(gdkBg.red >> 8, gdkBg.green >> 8, gdkBg.blue >> 8);
    }

private:
    Ptr_gtk_widget_get_style gtk_widget_get_style;
    Ptr_gtk_menu_bar_new gtk_menu_bar_new;

    static QHash<QString, GtkWidget *> *widgetMap;

    static inline void destroyWidgetMap()
    {
        cleanupGtkWidgets();
        delete widgetMap;
        widgetMap = 0;
    }

    static void cleanupGtkWidgets()
    {
        if (!widgetMap)
            return;
        if (widgetMap->contains("GtkWindow")) // Gtk will destroy all children
            gtk_widget_destroy(widgetMap->value("GtkWindow"));
        widgetMap->clear();
    }

    static inline QHash<QString, GtkWidget *> *gtkWidgetMap()
    {
        if (!widgetMap) {
            widgetMap = new QHash<QString, GtkWidget *>();
            qAddPostRoutine(destroyWidgetMap);
        }
        return widgetMap;
    }

    static void addAllSubWidgets(GtkWidget *widget, gpointer v)
    {
        Q_UNUSED(v);
        addWidgetToMap(widget);
        if (G_TYPE_CHECK_INSTANCE_TYPE((widget), gtk_container_get_type()))
            gtk_container_forall((GtkContainer *) widget, addAllSubWidgets, NULL);
    }

    static GtkWidget *gtkWidget(const QString &path)
    {
        GtkWidget *widget = gtkWidgetMap()->value(path);
        if (!widget) {
            // Theme might have rearranged widget internals
            widget = gtkWidgetMap()->value(path);
        }
        return widget;
    }

    static void setupGtkWidget(GtkWidget *widget)
    {
        if (Q_GTK_IS_WIDGET(widget)) {
            qDebug() << "Registering widget...";
            GtkWidget *protoLayout = gtkWidgetMap()->value("GtkContainer");
            if (!protoLayout) {
                protoLayout = gtk_fixed_new();
                gtk_container_add((GtkContainer *) (gtkWidgetMap()->value("GtkWindow")),
                                  protoLayout);
                QString widgetPath = "GtkContainer";
                gtkWidgetMap()->insert(widgetPath, protoLayout);
            }
            Q_ASSERT(protoLayout);

            if (!gtk_widget_get_parent(widget) && !gtk_widget_is_toplevel(widget))
                gtk_container_add((GtkContainer *) (protoLayout), widget);
            gtk_widget_realize(widget);
        }
    }

    static void addWidgetToMap(GtkWidget *widget)
    {
        if (Q_GTK_IS_WIDGET(widget)) {
            gtk_widget_realize(widget);
            QString widgetPath = classPath(widget);

            removeWidgetFromMap(widgetPath);
            gtkWidgetMap()->insert(widgetPath, widget);
        }
    }

    static void removeWidgetFromMap(const QString &path) { gtkWidgetMap()->remove(path); }

    static QString classPath(GtkWidget *widget)
    {
        char *class_path;
        gtk_widget_path(widget, NULL, &class_path, NULL);

        char *copy = class_path;
        if (strncmp(copy, "GtkWindow.", 10) == 0)
            copy += 10;
        if (strncmp(copy, "GtkFixed.", 9) == 0)
            copy += 9;

        copy = strdup(copy);

        g_free(class_path);

        qDebug() << "Class path" << copy;

        return copy;
    }
};

#endif // GTK_STYLE_H
