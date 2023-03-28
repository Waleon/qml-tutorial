/****************************************
* @brief    QML Rectangle 元素
* @blog     https://waleon.blog.csdn.net/article/details/129814075
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick
import QtQuick.Layouts

// 矩形元素（Rectangle）
Rectangle {
    id: rectanglePage

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Item {
            Layout.fillWidth: true
        }

        // 1. 简单的矩形
        Rectangle {
            width: 100
            height: 100
            color: "green"
        }

        // 2. 带渐变的矩形
        Rectangle {
            width: 100
            height: 100
            gradient: Gradient {
                GradientStop { position: 0.0; color: "lightgreen" }
                GradientStop { position: 1.0; color: "green" }
            }
        }

        // 3. 带边框的矩形
        Rectangle {
            width: 100
            height: 100
            color: "green"
            border.color: "black"
            border.width: 2
        }

        // 4. 圆角矩形
        Rectangle {
            width: 100
            height: 100
            color: "green"
            radius: 10
        }

        // 5. 圆形
        Rectangle {
            width: 100
            height: width
            color: "green"
            radius: width/2
        }

        // 6. 圆环
        Rectangle {
            width: 100
            height: width
            border.color: "green"
            border.width: 20
            radius: width/2
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
