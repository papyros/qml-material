/*
 * QML Material - An application framework implementing Material Design.
 * Copyright (C) 2015 Ricardo Vieira <ricardo.vieira@tecnico.ulisboa.pt>
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

#include <qqmlextensionplugin.h>

#include <qqmlengine.h>
#include <qquickimageprovider.h>
#include <QImage>
#include <QPainter>
#include <QSvgRenderer>

#include <QDebug>

class MaterialIconProvider : public QQuickImageProvider
{
public:
    MaterialIconProvider()
        : QQuickImageProvider(QQuickImageProvider::Image)
    {
    }

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize)
    {
        QString iconPath = "/lib/qt/qml/Material/icons/" + id + ".svg";

        QSvgRenderer renderer;
        if (!renderer.load(iconPath))
            qWarning() << "Unable to load image:" << iconPath;

        QImage image(requestedSize.width() > 0 ? requestedSize.width() : renderer.defaultSize().width(),
                     requestedSize.height() > 0 ? requestedSize.height() : renderer.defaultSize().height(),
                     QImage::Format_ARGB32_Premultiplied);
        image.fill(Qt::transparent);

        if (size)
            *size = image.size();

        QPainter p(&image);
        renderer.render(&p);

        return image;
    }
};

class ImageProviderExtensionPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "Material")
public:
    void registerTypes(const char *uri)
    {
        Q_UNUSED(uri);
    }

    void initializeEngine(QQmlEngine *engine, const char *uri)
    {
        Q_UNUSED(uri);
        engine->addImageProvider("material", new MaterialIconProvider);
    }

};

#include "materialiconprovider.moc"
