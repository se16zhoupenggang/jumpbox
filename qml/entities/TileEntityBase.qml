import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: tiledEntity
    property int column: 0
    property double row: 0
    property int size
    // gets set in Platform.qml and Ground.qml

    //而不是直接修改您的瓦片的X和Y值，我们引入了行和列以便于定位，请看Lay1.qML如何使用它们。
    x: row * gameScene.gridSize
    y: level.height - (column + 1) * gameScene.gridSize
    width: gameScene.gridSize * size
    height: gameScene.gridSize
}
