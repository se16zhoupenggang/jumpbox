import QtQuick 2.0
import VPlay 2.0
import "../common"
import "../entities"

SceneBase {
    id: scene

    signal gamePressed
    signal networkPressed

    Background {
        anchors.fill: parent.gameWindowAnchorItem
    }
    MultiResolutionImage {
        width: 200
        height: 80
        anchors.top: parent.top
        anchors.topMargin: 60
        anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
        source: "../../assets/promo.png"
    }

    Menu {
        anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
        anchors.bottom: scene.gameWindowAnchorItem.bottom

        onNetworkPressed: networkPressed()
        onPlayPressed: gamePressed()
    }

    /*onEnterPressed: {
        gamePressed()
    }*/
}
