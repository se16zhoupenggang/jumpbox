import QtQuick 2.0
import VPlay 2.0

TileEntityBase {
    id: platform
    entityType: "platform"

    size: 2 //必须> = 2和甚至（2,4,6-三……），因为我们已经有了一个的开始，一个为2的结局和中心sprites，是唯一的repeatable如果都是用

    Row {
        id: tileRow
        Tile {
            pos: "left"
            image: "../../assets/gsl.png"
        }
        Repeater {
            model: size - 2
            Tile {
                pos: "mid"
                image: "../../assets/gsm" + index % 2 + ".png"
            }
        }
        Tile {
            pos: "right"
            image: "../../assets/gsr.png"
        }
    }

    BoxCollider {
        id: collider
        anchors.fill: parent
        bodyType: Body.Static

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if (otherEntity.entityType === "player") {
                console.debug("contact platform begin")

                player.contacts++
            }
        }

        fixture.onEndContact: {
            var otherEntity = other.getBody().target
            if (otherEntity.entityType === "player") {
                console.debug("contact platform end")

                player.contacts--
            }
        }
    }
}
