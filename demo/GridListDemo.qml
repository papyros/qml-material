import QtQuick 2.0
import Material 0.1
import Material.Tiles 0.1 as Tile

Item {
    anchors.fill: parent
    anchors.margins: Units.dp(16)

    GridList {
        id: gridList

        model: 10
        breakpoints: [480,600,1024]
        padding: Units.dp(1)
        tileRatio: "4:3"
        delegate: Tile.TitleTile {
            primaryText: "Get the full story behind image "+(modelData+1)
            imageSource: "http://lorempixel.com/400/200/sports/"+(modelData+1)
        }
    }
}

