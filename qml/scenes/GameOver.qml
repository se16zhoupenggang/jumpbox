//周鵬剛
import QtQuick 2.0
import VPlay 2.0
import "../common"

Scene {
    id: gameOver
    width: 960
    height: 480
    opacity: 0

    signal retry
    signal back
    signal exit

    BackgroundImage {
        id: bgImage
        source: "../../assets/bg2.png"
    }
    Rectangle {
        id: retryButton
        width: 0.2 * parent.width
        height: 0.1 * parent.height
        anchors.bottom: backButton.top
        anchors.bottomMargin: 0.05 * parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        Image {
            id: retryImage
            anchors.fill: parent
            source: "../../assets/retry.png"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                retry()
            }
        }
    }
    Rectangle {
        id: backButton
        color: "white"
        width: 0.2 * parent.width
        height: 0.1 * parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Image {
            id: backImage
            anchors.fill: parent
            source: "../../assets/kaishi.jpg"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                back()
            }
        }
    }
    Rectangle {
        id: exitButton
        width: 0.2 * parent.width
        height: 0.1 * parent.height
        anchors.top: backButton.bottom
        anchors.topMargin: 0.05 * parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        Image {
            id: exitImage
            source: "../../assets/tuichu.jpg"
            anchors.fill: parent
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                exit()
            }
        }
    }
}
