import VPlay 2.0
import QtQuick 2.0

Item {
    width: gameScene.gridSize
    height: gameScene.gridSize
    property alias image: sprite.source
    property string pos: "mid" // can be either "mid","left" or "right"

    MultiResolutionImage {
        id: sprite
        //锚定是必要的，因为开始和结束瓦块实际上大于网格大小，因为它们有一些草从边缘悬挂，我们将（为了简单起见）在碰撞检测时忽略。
        anchors.left: pos == "right" ? parent.left : undefined
        anchors.right: pos == "left" ? parent.right : undefined
    }
}
