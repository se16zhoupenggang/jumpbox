//陽帥
import VPlay 2.0
import QtQuick 2.0

Item {
    width: bg.width
    height: bg.height
    MultiResolutionImage {
        id: bg
        source: "../../assets/bg2.png"
    }
    MultiResolutionImage {
        id: rotor
        source: "../../assets/boxblue.png"
        x: parent.width / 3
        y: parent.height / 2
        width: 30
        height: 30
    }

    MovementAnimation {
        target: rotor
        property: "rotation"
        velocity: 180
        running: true
    }
}
