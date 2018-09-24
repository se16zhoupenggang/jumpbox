import VPlay 2.0
import QtQuick 2.0
import "scenes"


//import "common"
Item {
    id: mainItem
    GameScene {
        id: gameScene
        onGameOver: {
            mainItem.state = "gameover"
        }
    }
    MenuScene {
        id: menuScene
        onGamePressed: {
            mainItem.state = "game"
        }
    }
    GameOver {
        id: gameOver
        onRetry: {
            mainItem.state = "game"
            gameScene.life = 2 //重置生命
        }
        onBack: {
            mainItem.state = "menu"
            gameScene.life = 2
        }
        onExit: {
            Qt.quit()
        }
    }

    state: "menu"

    states: [
        State {
            name: "menu"
            PropertyChanges {
                target: menuScene
                opacity: 1
            }
            PropertyChanges {
                target: window
                activeScene: menuScene
            }
        },
        State {
            name: "game"
            PropertyChanges {
                target: gameScene
                opacity: 1
            }
            PropertyChanges {
                target: window
                activeScene: gameScene
            }
        },
        State {
            name: "gameover"
            PropertyChanges {
                target: gameOver
                opacity: 1
            }
            PropertyChanges {
                target: window
                activeScene: gameOver
            }
        }
    ]
    onStateChanged: {
        if (state == "game") {
            gameScene.startgame()
        }
    }
}
