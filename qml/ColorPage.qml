/****************************************
* @brief    QML 颜色表示法
* @blog     https://waleon.blog.csdn.net/article/details/129230582
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11

Rectangle {
    id: colorPage

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Item {
            Layout.fillWidth: true
        }

        // 1. 颜色名（如 "red"、"green" 或者 "blue"）
        Rectangle {
            width: 100; height: 100
            color: "steelblue"  // 钢蓝色
        }
        Rectangle {
            width: 100; height: 100
            color: "CORAL"  // 珊瑚色
        }

        // 2. 十六进制颜色值：三元组形式 "#RRGGBB"，四元组形式 "#AARRGGBB"
        Rectangle {
            width: 100; height: 100
            color: "#FF0000"  // 红色
        }
        Rectangle {
            width: 100; height: 100
            color: "#3F0000FF"  // 75% 透明度的蓝色
        }

        // 3. 颜色相关的函数：Qt.rgba()、Qt.hsva()、Qt.hsla()、Qt.darker()、Qt.lighter() 或者 Qt.tint()
        Rectangle {
            width: 100; height: 100
            color: Qt.rgba(0, 1, 0, 1)  // 绿色
        }
        Rectangle {
            width: 100; height: 100
            color: Qt.lighter("red")  // 浅红色
        }

        // 4. color 类型有 r、g、b 和 a 属性，分别表示红、绿、蓝和 alpha 值
        Rectangle {
            width: 100; height: 100
            color: "blue"

            // 打印 "0 0 1 1"
            Component.onCompleted: {
                console.info(color.r, color.g, color.b, color.a)
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
