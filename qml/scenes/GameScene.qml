import VPlay 2.0
import QtQuick 2.0
import "../entities"
import "../levels"
import my.score 1.0

Scene {
    id: gameScene
    // the "logical size" - the scene content is auto-scaled to match the GameWindow size
    width: 480
    height: 320
    gridSize: 32
    signal menuPressed
    signal gameOver
    property int offsetBeforeScrollingStarts: 240
    property int life: 2

    EntityManager {
        id: entityManager
    }

    // the whole screen is filled with an incredibly beautiful blue ...
    Rectangle {
        Image {
            id: bg1
            source: "../../assets/bg1.png"
            width: parent.width
            height: parent.height
            opacity: 0.5
        }
        anchors.fill: gameScene.gameWindowAnchorItem
        color: "#74d6f7"
    }

    // ... followed by 2 parallax layers with trees and grass
    ParallaxScrollingBackground {
        opacity: 0.7
        sourceImage: "../../assets/pbg1.png"

        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        // we move the parallax layers at the same speed as the player
        movementVelocity: player.x > offsetBeforeScrollingStarts ? Qt.point(
                                                                       -player.horizontalVelocity,
                                                                       0) : Qt.point(
                                                                       0, 0)
        // the speed then gets multiplied by this ratio to create the parallax effect
        ratio: Qt.point(0.5, 1)
    }
    ParallaxScrollingBackground {
        opacity: 0.2
        sourceImage: "../../assets/groundSquare1.png"
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        movementVelocity: player.x > offsetBeforeScrollingStarts ? Qt.point(
                                                                       -player.horizontalVelocity,
                                                                       0) : Qt.point(
                                                                       0, 0)
        ratio: Qt.point(0.6, 0)
    }

    // this is the moving item containing the level and player
    Item {
        id: viewPort
        height: level.height
        width: level.width
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        x: player.x > offsetBeforeScrollingStarts ? offsetBeforeScrollingStarts - player.x : 0

        PhysicsWorld {
            id: physicsWorld
            gravity: Qt.point(0, 50)
            //            debugDrawVisible: true // enable this for physics debugging
            z: 1000

            onPreSolve: {
                //this is called before the Box2DWorld handles contact events
                var entityA = contact.fixtureA.getBody().target
                var entityB = contact.fixtureB.getBody().target
                if (entityB.entityType === "platform"
                        && entityA.entityType === "player"
                        && entityA.y + entityA.height > entityB.y) {
                    //by setting enabled to false, they can be filtered out completely
                    //-> disable cloud platform collisions when the player is below the platform
                    contact.enabled = false
                }
            }
        }

        // you could load your levels Dynamically with a Loader component here
        Level1 {
            id: level
        }

        Timer {
            id: movetotal
            interval: 5000
            repeat: true
            running: true

            onTriggered: {
                move.direction = !move.direction
            } //5s yizhuanxiang
        }
        Timer {
            id: move
            interval: 10
            repeat: true
            running: true
            property int change: 1
            property bool direction
            onTriggered: {
                if (direction) {
                    level.m1.row += 0.0375
                    level.m2.row += 0.0375
                    level.m3.row += 0.0375
                    level.m4.row += 0.0375
                } else {
                    level.m1.row -= 0.0375
                    level.m2.row -= 0.0375
                    level.m3.row -= 0.0375
                    level.m4.row -= 0.0375
                }
            }
        }

        Player {
            id: player
            x: 0
            y: 50

            onPlayerdie: {
                resetSensor.contact()
            }
        }

        ResetSensor {
            id: resetSensor
            width: player.width
            height: 10
            x: player.x
            anchors.bottom: viewPort.bottom
            // if the player collides with the reset sensor, he goes back to the start
            onContact: {
                life--
                player.x = 10
                player.y = 20
            }
            // this is just for you to see how the sensor moves, in your real game, you should position it lower, outside of the visible area
            //            Rectangle {
            //                anchors.fill: parent
            //                color: "yellow"
            //                opacity: 0.5
            //            }
        }
    }
    onLifeChanged: {
        if (life === 0) {
            scoreSave.resetScore()
            gameOver()
        }
    }

    Rectangle {
        // you should hide those input controls on desktops, not only because they are really ugly in this demo, but because you can move the player with the arrow keys there
        visible: !system.desktopPlatform
        enabled: visible
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 50
        width: 150
        color: "blue"
        opacity: 0

        Rectangle {
            anchors.centerIn: parent
            width: 1
            height: parent.height
            color: "white"
        }
        MultiPointTouchArea {
            anchors.fill: gameScene
            onPressed: {
                if (touchPoints[0].x < width / 2)
                    controller.xAxis = -1
                else
                    controller.xAxis = 1
            }
            onUpdated: {
                if (touchPoints[0].x < width / 2)
                    controller.xAxis = -1
                else
                    controller.xAxis = 1
            }
            onReleased: controller.xAxis = 0
        }
    }

    Rectangle {
        // same as the above input control
        visible: !system.desktopPlatform
        enabled: visible
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        height: 300
        width: 300
        color: "green"
        opacity: 0

        Text {
            anchors.centerIn: parent
            text: "jump"
            color: "white"
            font.pixelSize: 9
        }
        MouseArea {
            anchors.fill: parent
            onPressed: player.jump()
        }
    }

    // on desktops, you can move the player with the arrow keys, on mobiles we are using our custom inputs above to modify the controller axis values. With this approach, we only need one actual logic for the movement, always referring to the axis values of the controller
    Keys.forwardTo: controller
    TwoAxisController {
        id: controller
        onInputActionPressed: {
            console.debug("key pressed actionName " + actionName)
            if (actionName == "up") {
                player.jump()
            }
        }
    }

    Score {
        id: scoreSave
        score: 0
    }
    Timer {
        id: scoreTimer
        repeat: true
        interval: 50
        running: true
        onTriggered: {
            scoreSave.score += 1
        }
    }
    Text {
        anchors.top: parent.top
        anchors.left: parent.left
        text: "score:" + scoreSave.score
        font.pixelSize: 30
        color: "red"
    }
    function startgame() {
        player.startgame()
    }
}
