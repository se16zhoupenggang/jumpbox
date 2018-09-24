//陽帥
import QtQuick 2.0
import VPlay 2.0


// base component for all scenes in the game游戏中所有场景的基本组件
Scene {
    id: sceneBase
    // this is important, as it serves as the reference size for the mass of the physics objects, because the mass of a body depends on the width of its images 这是重要的，因为它作为物理对象的质量的参考尺寸，因为身体的质量取决于其图像的宽度。
    width: 960
    height: 480

    opacity: 0
    // NOTE: in qt5, an opaque element is not invisible by default and would handle the mouse and keyboard input!注意：在QT5中，不透明元素在默认情况下是不可见的，将处理鼠标和键盘输入！
    // thus to disable also keyboard focus and mouse handling and make an item invisible, set visible and enabled property depending on opacity 因此，禁用键盘焦点和鼠标处理，使项不可见，根据不透明度设置可见和启用属性。
    visible: opacity === 0 ? false : true
    enabled: visible

    Behavior on opacity {
        NumberAnimation {
            duration: 250
        }
    }

    signal enterPressed

    Keys.onPressed: {
        if (event.key === Qt.Key_Return) {
            enterPressed()
        }
    }

    Keys.onReturnPressed: {
        enterPressed()
    }
}
