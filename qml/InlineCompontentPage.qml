/****************************************
* @brief    QML 可重用组件
* @blog     https://waleon.blog.csdn.net/article/details/129456882
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick
import QtQuick.Layouts

Rectangle {
    id: inlineCompontentPage

    // 定义内联组件
    component InlineStateButton : Item {
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

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Item {
            Layout.fillWidth: true
        }

        // 使用内联组件
        InlineStateButton {
            id: homeButton
            text: "Home"
            onClicked: console.info("home button clicked")
        }
        InlineStateButton {
            background: "orange"
            text: "About"
            onClicked: console.info("about button clicked")
        }
        InlineStateButton {
            background: "green"
            text: "Contact"
            onClicked: console.info("contact button clicked")
        }

        Item {
            Layout.fillWidth: true
        }
    }

    // 属性声明
    property InlineStateButton selectedButton: homeButton

    Component.onCompleted: {
        console.info("selectedButton:", selectedButton.text)
    }
}
