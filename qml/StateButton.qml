/****************************************
* @brief    QML 可重用组件
* @blog     https://waleon.blog.csdn.net/article/details/129456882
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick 2.11

Item {
    id: root

    // 属性声明
    property alias text: label.text
    property color background: "blue"

    // 信号声明
    signal clicked()

    width: 150; height: 80

    Rectangle {
        anchors.fill: parent
        // 背景色（三态）
        color: mouse.containsMouse
               ? (mouse.pressed
                  ? Qt.rgba(background.r, background.g, background.b, 0.85)
                  : Qt.rgba(background.r, background.g, background.b, 0.7))
               : background

        // 显示文本
        Text {
            id: label
            anchors.centerIn: parent
            color: "white"
        }

        // 鼠标区域
        MouseArea {
            id: mouse
            anchors.fill: parent
            hoverEnabled: true
            onClicked: root.clicked()
        }
    }
}
