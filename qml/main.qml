﻿/****************************************
* @brief    细说 QML
* @blog     https://waleon.blog.csdn.net/category_9267924.html
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4

ApplicationWindow  {
    id: rootWindow
    title: "QML Examples"
    width: 800
    height: 600
    visible: true

    RowLayout {
        anchors.fill: parent

        ListView {
            id: listView
            Layout.preferredWidth: 150
            Layout.fillHeight: true
            currentIndex: -1

            model: ListModel {
                ListElement { title: "Layout"; source: "qrc:/qml/qml/LayoutPage.qml" }
                ListElement { title: "Color"; source: "qrc:/qml/qml/ColorPage.qml" }
                ListElement { title: "Mouse Events"; source: "qrc:/qml/qml/MouseEventsPage.qml" }
                ListElement { title: "Key Events"; source: "qrc:/qml/qml/KeyEventsPage.qml" }
                ListElement { title: "Timer"; source: "qrc:/qml/qml/TimerPage.qml" }
                ListElement { title: "Z-Order"; source: "qrc:/qml/qml/ZOrderPage.qml" }
                ListElement { title: "Compontent"; source: "qrc:/qml/qml/CompontentPage.qml" }
            }

            delegate: ItemDelegate {
                width: parent.width
                text: model.title
                highlighted: ListView.isCurrentItem
                onClicked: {
                    listView.currentIndex = index
                }
            }

            onCurrentIndexChanged: {
                var item = model.get(currentIndex)
                if (item)
                    stackView.push(item.source)
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }

        StackView {
            id: stackView
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        // 在实例化后触发
        Component.onCompleted: {
            listView.currentIndex = 0
        }
    }
}