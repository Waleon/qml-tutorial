/****************************************
* @brief    QML 键盘事件
* @blog     https://waleon.blog.csdn.net/article/details/129309600
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11

Rectangle {
    id: keyEventsPage

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Item {
            Layout.fillWidth: true
        }

        // 1. 通用键盘事件
        Rectangle {
            width: 100
            height: 100
            color: focus ? "green" : "black"

            // 按下 Tab 键，或者点击鼠标获取焦点
            activeFocusOnTab: true
            MouseArea {
                anchors.fill: parent
                onClicked: parent.forceActiveFocus()
            }

            // 可处理大部分按键事件
            Keys.onPressed: {
                console.info("key %1(%2) was pressed".arg(event.text).arg(event.key))

                switch(event.key) {
                case Qt.Key_Left:
                    x -= 10;
                    break;
                case Qt.Key_Right:
                    x += 10;
                    break;
                case Qt.Key_Up:
                    y -= 10;
                    break;
                case Qt.Key_Down:
                    y += 10;
                    break;
                default:
                    return;
                }
            }
        }

        // 2. 专用键盘事件
        Rectangle {
            width: 100
            height: 100
            color: focus ? "green" : "black"

            activeFocusOnTab: true
            MouseArea {
                anchors.fill: parent
                onClicked: parent.forceActiveFocus()
            }

            // 专用按键 - 方向键：左、右、上、下
            Keys.onLeftPressed: {
                x -= 10
            }
            Keys.onRightPressed: {
                x += 10
            }
            Keys.onUpPressed: {
                y -= 10
            }
            Keys.onDownPressed: {
                y += 10
            }
        }

        // 3. 对组合键处理
        Rectangle {
            width: 100
            height: 100
            color: focus ? "green" : "black"

            activeFocusOnTab: true
            MouseArea {
                anchors.fill: parent
                onClicked: parent.forceActiveFocus()
            }

            // Ctrl + Shift + 方向键
            Keys.onPressed: {
                if ((event.modifiers & Qt.ControlModifier) && (event.modifiers & Qt.ShiftModifier)) {
                    switch(event.key) {
                    case Qt.Key_Left:
                        x -= 10;
                        break;
                    case Qt.Key_Right:
                        x += 10;
                        break;
                    case Qt.Key_Up:
                        y -= 10;
                        break;
                    case Qt.Key_Down:
                        y += 10;
                        break;
                    default:
                        return;
                    }
                }
            }
        }

        // 4. 按键事件传递顺序
        Rectangle {
            id: rect
            width: 150
            height: 150
            color: focus ? "green" : "black"

            // 按下 Tab 键，或者点击鼠标获取焦点
            activeFocusOnTab: true
            MouseArea {
                anchors.fill: parent
                onClicked: parent.forceActiveFocus()
            }

            // 设置按键事件传递的顺序
            Keys.forwardTo: [subRect2, subRect1]

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                Item {
                    Layout.fillWidth: true
                }

                Rectangle {
                    id: subRect1
                    width: 50
                    height: 50
                    color: "orange"

                    Keys.onPressed: {
                        console.info("subRect1 pressed")

                        switch(event.key) {
                        case Qt.Key_Left:
                            x -= 10;
                            break;
                        case Qt.Key_Right:
                            x += 10;
                            break;
                        case Qt.Key_Up:
                            y -= 10;
                            break;
                        case Qt.Key_Down:
                            y += 10;
                            break;
                        default:
                            return;
                        }
                    }
                }

                Rectangle {
                    id: subRect2
                    width: 50
                    height: 50
                    color: "orange"

                    Keys.onPressed: {
                        console.info("subRect2 pressed")

                        switch(event.key) {
                        case Qt.Key_Left:
                            x -= 10;
                            break;
                        case Qt.Key_Right:
                            x += 10;
                            break;
                        case Qt.Key_Up:
                            y -= 10;
                            event.accepted = true;  // 表明事件已被处理，无需继续传递
                            break;
                        case Qt.Key_Down:
                            y += 10;
                            event.accepted = true;
                            break;
                        default:
                            return;
                        }
                    }
                }

                Item {
                    Layout.fillWidth: true
                }
            }
        }

        // 5. 导航切换
        GridLayout {
            width: 100; height: 100
            columns: 2

            Rectangle {
                id: topLeft
                width: 50; height: 50
                color: focus ? "green" : "black"
                MouseArea {
                    anchors.fill: parent
                    onClicked: parent.forceActiveFocus()
                }

                KeyNavigation.right: topRight
                KeyNavigation.down: bottomLeft
            }

            Rectangle {
                id: topRight
                width: 50; height: 50
                color: focus ? "green" : "black"

                KeyNavigation.left: topLeft
                KeyNavigation.down: bottomRight
            }

            Rectangle {
                id: bottomLeft
                width: 50; height: 50
                color: focus ? "green" : "black"

                KeyNavigation.right: bottomRight
                KeyNavigation.up: topLeft
            }

            Rectangle {
                id: bottomRight
                width: 50; height: 50
                color: focus ? "green" : "black"

                KeyNavigation.left: bottomLeft
                KeyNavigation.up: topRight
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
