//陽帥
import VPlay 2.0
import QtQuick 2.0

Column {
    signal playPressed
    signal networkPressed

    spacing: 25
    //anchors.horizontalCenter: parent.horizontalCenter
    height: menuItem.height * 4

    ImageButton {
        id: menuItem
        onClicked: {
            playPressed()
        }
        source: "../../assets/ee.png"
    }

    ImageButton {
        id: menuTem2
        onClicked: {
            networkPressed()
        }
        source: "../../assets/rr.png"
    }
}
