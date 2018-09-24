//周鵬剛 surperjump
import VPlay 2.0
import QtQuick 2.0
import my.timer 1.0

EntityBase {
    id: player
    entityType: "player"
    width: 35
    height: 35
    transformOrigin: Item.Center
    // add some aliases for easier access to those properties from outside 添加一些别名，以便更容易地从外部访问这些属性
    property alias collider: collider
    property alias horizontalVelocity: collider.linearVelocity.x
    signal playerdie

    // the contacts property is used to determine if the player is in touch with any solid objects (like ground or platform), because in this case the player is walking, which enables the ability to jump. contacts > 0 --> walking state 联系人属性被用来确定玩家是否与任何固体物体（如地面或平台）接触，因为在这种情况下玩家正在行走，这使得能够跳跃。接触＞0＞行走状态
    property int contacts: 0
    // property binding to determine the state of the player like described above 属性绑定以确定的状态，如上文所述
    state: contacts > 0 ? "walking" : "jumping"
    onStateChanged: console.debug("player.state " + state)

    // here you could use a SpriteSquenceVPlay to animate your player 在这里你可以使用SpisteQueNekEvoto动画你的播放器。
    MultiResolutionImage {
        id: pimage
        source: "../../assets/boxangry.png"
        width: parent.width
        height: parent.height
    }
    RotationAnimation {
        id: rotation
        target: pimage
        from: 0
        to: 360
        direction: rotationAnimation.Clockwise
        duration: 500
    }

    BoxCollider {
        id: collider
        height: parent.height
        width: 30
        anchors.horizontalCenter: parent.horizontalCenter
        // this collider must be dynamic because we are moving it by applying forces and impulses 这个对撞机必须是动态的，因为我们通过施加力和脉冲来移动它。
        bodyType: Body.Dynamic // this is the default value but I wanted to mention it ;) 这是默认值，但我想提一下；
        fixedRotation: true // we are running, not rolling...
        bullet: true // for super accurate collision detection, use this sparingly, because it's quite performance greedy
        sleepingAllowed: false
        // apply the horizontal value of the TwoAxisController as force to move the player left and right
        force: Qt.point(2 * 170 * 32, 0)
        // limit the horizontal velocity
        onLinearVelocityChanged: {
            if (linearVelocity.x > 170)
                linearVelocity.x = 170
            if (linearVelocity.x < 0)
                linearVelocity.x = 0
        }
    }

    // this timer is used to slow down the players horizontal movement. the linearDamping property of the collider works quite similar, but also in vertical direction, which we don't want to be slowed 这个计时器用来减缓球员的水平移动。对撞机的线性阻尼特性非常类似，但也在垂直方向上，我们不希望减慢。
    Timer {
        id: updateTimer
        // set this interval as high as possible to improve performance, but as low as needed so it still looks good
        interval: 60
        running: true
        repeat: true
        onTriggered: {
            var xAxis = controller.xAxis
            // if xAxis is 0 (no movement command) we slow the player down until he stops
            if (xAxis == 0) {
                if (Math.abs(player.horizontalVelocity) > 10)
                    player.horizontalVelocity /= 1.5
                else
                    player.horizontalVelocity = 0
            }
        }
    }
    MyTimer {
        id: timer
        second: 1
    }

    Connections {
        target: timer
        onCallChangeImage: {
            switch (num) {
            case 0:
                pimage.source = "../../assets/boxdevil.png"
                break
            case 1:
                pimage.source = "../../assets/boxblue.png"
                break
            case 2:
                pimage.source = "../../assets/boxice.png"
                break
            }
        }
    }

    function jump() {
        console.debug("jump requested at player.state " + state)
        if (player.state == "walking") {
            console.debug("do the jump")
            // for the jump, we simply set the upwards velocity of the collider
            collider.linearVelocity.y = -600
            rotation.start()
        }
    }

    function superjump() {
        if (player.state == "walking") {
            console.debug("do the jump")
            // for the jump, we simply set the upwards velocity of the collider
            collider.linearVelocity.y = -800
            rotation.start()
        }
    }
    function startgame() {
        timer.startTimer()
    }
}
