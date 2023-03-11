/****************************************
* @brief    QML 可重用组件
* @blog     https://waleon.blog.csdn.net/article/details/129456882
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: compontentPage

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Item {
            Layout.fillWidth: true
        }

        StateButton {
            text: "Home"
            onClicked: console.info("home button clicked")
        }
        StateButton {
           background: "orange"
           text: "About"
           onClicked: console.info("about button clicked")
        }
        StateButton {
           background: "green"
           text: "Contact"
           onClicked: console.info("contact button clicked")
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
