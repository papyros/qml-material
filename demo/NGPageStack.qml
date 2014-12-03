import QtQuick 2.0
import QtQuick.Controls 1.2 as Controls
import Material 0.1

Controls.StackView {
    id: stackView

    signal pushed( Item page )
    signal popped( )

    property int __lastDepth: 0
    property Item __oldItem: null

    onCurrentItemChanged: {
        if ( stackView.currentItem && __lastDepth > stackView.depth ) {
            popped( );

        }

        if ( stackView.currentItem && __lastDepth < stackView.depth ) {
            pushed( stackView.currentItem);
        }

        if ( stackView.currentItem  ) {
            stackView.currentItem.backAction.visible = (stackView.depth > 1);
        }

        __lastDepth = stackView.depth;
    }
}
