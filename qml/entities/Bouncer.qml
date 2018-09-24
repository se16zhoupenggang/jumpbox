//陽帥
import QtQuick 2.0
import VPlay 2.0

TileEntityBase {
    id: bouncer
    entityType: "bouncer"

    size: 2 //必须是＞2，因为我们有一个启动子，一个用于结束，一个可重复的中心精灵。

    Row {
        id: tileRow
        Tile {
            pos: "left"
            image: "../../assets/tiao1.png"
        }
        Repeater {
            model: size - 2
            Tile {
                pos: "mid"
                image: "../../assets/tiao2.png"
            }
        }
        Tile {
            pos: "right"
            image: "../../assets/tiao3.png"
        }
    }
    BoxCollider {

        anchors.fill: parent
        bodyType: Body.Static //she zhi yi ge jing tai de ti
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if (otherEntity.entityType === "player")
                player.contacts++
            player.superjump()
        }
        fixture.onEndContact: {
            var otherEntity = other.getBody().target
            if (otherEntity.entityType === "player")
                player.contacts--
        }
    }
}
