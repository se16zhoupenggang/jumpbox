//陽攀平
//周鵬剛 移動平板
import VPlay 2.0
import QtQuick 2.0
import "../entities"
import "." as Levels

Levels.LevelBase {
    id: level
    //我们需要指定宽度以获得正确的调试绘图用于我们的物理

    //物理世界组件默认地填充它的父节点，这是GAMESENE的视口项，并且该项使用级别的大小。

    //Note：你的物理学也将在这里定义宽度，所以不用担心，你可以忽略它直到你想做一些物理调试。
    width: 42 * gameScene.gridSize //42，因为我们最后的瓦片是第12行的30号地。

    // you could draw your level on a graph paper and then add the tiles here only by defining their row, column and size
    property alias m1: m1
    property alias m2: m2
    property alias m3: m3
    property alias m4: m4
    Ground {
        row: 0
        column: 0
        size: 10
    }
    Ground {
        row: 8
        column: 1
        size: 2
    }

    Ground {
        row: 8
        column: 0
        size: 10
    }

    Platform {

        row: 12
        column: 3
        size: 6
    }
    Platform {

        row: 17
        column: 5
        size: 6
    }
    Platform {

        row: 21
        column: 7
        size: 6
    }
    Boom {
        row: 23
        column: 4
        size: 2
    }

    Platform {

        row: 28
        column: 3
        size: 10
    }

    Platform {
        id: m1
        row: 28
        column: 3
        size: 10
    }
    Ground {
        row: 30
        column: 0
        size: 5
    }
    Platform {
        row: 30
        column: 6
        size: 4
    }
    Platform {
        row: 35
        column: 3
        size: 3
    }

    Bouncer {
        row: 38
        column: 3
        size: 2
    }

    Platform {
        row: 45
        column: 3
        size: 6
    }
    Platform {
        id: m2
        row: 47
        column: 6
        size: 6
    }

    Bouncer {
        row: 55
        column: 3
        size: 2
    }
    Boom {
        row: 57
        column: 4
        size: 2
    }
    Platform {
        row: 50
        column: 3
        size: 5
    }

    Bouncer {
        row: 80
        column: 6
        size: 2
    }
    Platform {
        row: 60
        column: 6
        size: 15
    }
    Platform {
        id: m3
        row: 80
        column: 3
        size: 8
    }
    Ground {
        row: 65
        column: 0
        size: 30
    }

    Platform {
        row: 97
        column: 2
        size: 6
    }
    Platform {
        row: 104
        column: 5
        size: 6
    }
    Platform {
        row: 111
        column: 7
        size: 6
    }
    Platform {
        id: m4
        row: 118
        column: 4
        size: 6
    }
    Ground {

        row: 115
        column: 2
        size: 60
    }
}
