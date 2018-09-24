import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: resetSensor
    entityType: "resetSensor"

    signal contact

    Text {
        anchors.centerIn: parent
        text: "reset sensor"
        color: "white"
        font.pixelSize: 9
    }

    BoxCollider {
        anchors.fill: parent
        collisionTestingOnlyMode: true
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            // 如果播放器/命中位置传感器或信号，我们希望是用于复位的播放器
            if (otherEntity.entityType === "player") {
                //我们也可以直接修改玩家的位置，但是信号的方法更干净，有助于分离组件。
                resetSensor.contact()
            }
        }
    }
}
