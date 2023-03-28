/****************************************
* @brief    QML 鼠标事件
* @blog     https://waleon.blog.csdn.net/article/details/129252688
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick
import QtQuick.Layouts

Rectangle {
    id: mouseEventsPage

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Item {
            Layout.fillWidth: true
        }

        // 1. 定义鼠标区域
        Rectangle {
            width: 100
            height: 100
            color: "green"

            // 充满父元素
            MouseArea {
                anchors.fill: parent
                onClicked: parent.color = Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
            }
        }

        // 2. 响应鼠标按键
        Rectangle {
            width: 100
            height: 100
            color: "blue"

            MouseArea {
                anchors.fill: parent
                // 支持所有可能的按钮
                acceptedButtons: Qt.AllButtons
                // 鼠标单击
                onClicked: (mouse)=> {
                               if (mouse.button === Qt.LeftButton) {
                                   console.info("left button clicked")
                               } else if (mouse.button === Qt.RightButton) {
                                   console.info("right button clicked")
                               } else if (mouse.button === Qt.MiddleButton) {
                                   console.info("middle button clicked")
                               }  else {
                                   console.info("button clicked: %1".arg(mouse.button))
                               }
                           }
                // 鼠标双击
                onDoubleClicked: (mouse)=> {
                                     if (mouse.button === Qt.LeftButton) {
                                         console.info("area double clicked")
                                     }
                                 }
                // 鼠标滚轮
                onWheel: (wheel)=> {
                    console.info("wheel button clicked, angleDelta: %1, x: %2, y: %3".arg(wheel.angleDelta).arg(wheel.x).arg(wheel.y))
                }
            }
        }

        // 3. 鼠标滑动事件
        Rectangle {
            width: 100
            height: 100
            color: "orange"

            MouseArea {
                anchors.fill: parent
                // 支持悬停
                hoverEnabled: true
                // 鼠标进入
                onEntered: console.info("mouse entered the area")
                // 鼠标离开
                onExited: console.info("mouse exited the area")
                // 鼠标位置改变
                onPositionChanged: (mouse)=> {
                    console.info("mouse position changed, x: %1, y: %2".arg(mouse.x).arg(mouse.y))
                }
            }
        }

        // 4. 鼠标区域重叠时，事件传递
        Rectangle {
            width: 100
            height: 100
            color: "yellow"
            MouseArea {
                anchors.fill: parent
                onClicked: console.info("area1 clicked")
            }

            // 定义小于父组件的区域
            // MouseArea 重叠时，propagateComposedEvents 为 true，mouse.accepted 为 false，事件将继续传递，直到被接收为止
            Rectangle {
                width: 50
                height: 50;
                color: "red"
                MouseArea {
                    anchors.fill: parent
                    propagateComposedEvents: true
                    onClicked: (mouse)=> {
                        onClicked: console.info("area2 clicked")
                        mouse.accepted = false
                    }
                }
            }
        }

        // 5. 拖拽功能
        Rectangle{
            id: container
            color: "purple"
            width: 100
            height: 100

            Rectangle {
                id: rect
                width: 50
                height: 50;
                color: Qt.lighter(container.color)

                MouseArea {
                    anchors.fill: parent
                    drag.target: rect  // 要拖拽的对象
                    drag.axis: Drag.XandYAxis  // 拖拽的方向
                    // 限制目标在相应轴上的拖动距离
                    drag.minimumX: 0
                    drag.maximumX: container.width - parent.width
                    drag.minimumY: 0
                    drag.maximumY: container.height - parent.height
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
