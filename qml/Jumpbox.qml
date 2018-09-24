// 簡單的插入背景音樂
import VPlay 2.0
import QtQuick 2.0

import "scenes"


//import "common"
GameWindow {
    id: window
    screenWidth: 960
    screenHeight: 480

    Component.onCompleted: {
        mainItemDelay.start()
    }

    Timer {
        id: mainItemDelay
        interval: 500
        onTriggered: {
            mainItemLoader.source = "MainItem.qml"
        }
    }

    BackgroundMusic {
        id: backgroundMusic
        source: "./../assets/Bgm1.mp3"

        autoPlay: true
    }

    Loader {
        id: mainItemLoader
    }
}
