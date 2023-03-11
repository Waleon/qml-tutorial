/****************************************
* @brief    QML中的5大布局
* @blog     https://waleon.blog.csdn.net/article/details/129222151
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11

Rectangle {
    id: layoutPage

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Item {
            Layout.fillWidth: true
        }

        // 1. 手动定位（x、y为常量）
        // 特点：适用于静态界面
        Rectangle {
            width: 200
            height: 200
            color: "black"

            // 位置、大小固定不变
            Rectangle {
                x: 50
                y: 50
                width: 50
                height: 50
                color: "green"
            }

            Rectangle {
                x: 100
                y: 100
                width: 50
                height: 50
                color: "yellow"
            }
        }

        // 2. 坐标绑定定位（x、y为绑定表达式）
        // 特点：最具动态性，但有性能成本
        Rectangle {
            id: rect
            width: 200
            height: rect.width
            color: "black"

            // 位置、大小取决于父矩形的大小
            Rectangle {
                x: rect.width / 4
                y: rect.width / 4
                width: rect.width / 4
                height: rect.width / 4
                color: "green"
            }

            Rectangle {
                x: rect.width / 2
                y: rect.width / 2
                width: rect.width / 4
                height: rect.width / 4
                color: "yellow"
            }
        }

        // 3. 锚定位（anchors）
        // 特点：性能优于基于绑定的布局
        Rectangle {
            width: 200
            height: 200
            color: "black"

            // 固定在父元素左上角 50px 处
            Rectangle {
                id: rect1
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: 50
                anchors.leftMargin: 50
                width: 50
                height: 50
                color: "green"
            }

            // 固定在 rect1 右下角处
            Rectangle {
                anchors.left: rect1.right
                anchors.top: rect1.bottom
                width: 50
                height: 50
                color: "yellow"
            }
        }

        // 4. 定位器（包括：Row、Column、Grid、Flow等）
        // 特点：比起锚定位，可以更方便的排列元素
        Rectangle {
            width: 200
            height: 200
            color: "black"

            Grid {
                topPadding: 50
                leftPadding: 50
                rows: 2
                columns: 2
                spacing: 0

                Rectangle {
                    width: 50
                    height: 50
                    color: "green"
                }
                // 这两个 Item 用于占位
                Item {
                    width: 50
                    height: 50
                }
                Item {
                    width: 50
                    height: 50
                }
                Rectangle {
                    width: 50
                    height: 50
                    color: "yellow"
                }
            }
        }

        // 5. 布局管理器（包括：RowLayout、ColumnLayout、GridLayout、StackLayout等）
        // 特点：比起定位器，可对布局进一步细化或限制，非常适合调整用户界面的大小
        Rectangle {
            width: 200
            height: 200
            color: "black"

            GridLayout {
                rows: 2
                columns: 2
                rowSpacing: 0
                columnSpacing: 0

                Rectangle {
                    id: rect6
                    // 为布局中的控件设置附加属性
                    Layout.topMargin: 50
                    Layout.leftMargin: 50
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 50
                    color: "green"
                }
                Item {
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 50
                }
                Item {
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 50
                }
                Rectangle {
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 50
                    color: "yellow"
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
