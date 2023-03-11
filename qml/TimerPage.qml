/****************************************
* @brief    QML 定时器
* @blog     https://waleon.blog.csdn.net/article/details/129340128
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick 2.11
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: timerPage

    // 更新日期时间
    function updateTime() {
        var currentDate = new Date()
        time.text = currentDate.toLocaleString(Qt.locale(), "yyyy-MM-dd hh:mm:ss")
    }

    Timer {
        id: timer
        interval: 1000  // 间隔 1000 毫秒
        repeat: true  // 重复触发
        running: true  // 启动定时器
        triggeredOnStart: true  // 定时器启动时立即触发
        onTriggered: updateTime()  // 更新日期时间
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Item {
            Layout.fillHeight: true
        }
        Text {
            id: time
            font.pointSize: 12
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        RowLayout {
            spacing: 10
            Item {
                Layout.fillWidth: true
            }

            // 启动定时器
            Button {
                text: "Start"
                onClicked: timer.start()
            }

            // 重启定时器
            Button {
                text: "Restart"
                onClicked: timer.restart()
            }

            // 停止定时器
            Button {
                text: "Stop"
                onClicked: timer.stop()
            }

            Item {
                Layout.fillWidth: true
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
