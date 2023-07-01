/****************************************
* @brief    《细说 QML》教程
* @blog     https://waleon.blog.csdn.net/category_9267924.html
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ApplicationWindow  {
    id: rootWindow
    title: "QML Tutorial"
    width: 1000
    height: 800
    visible: true

    RowLayout {
        anchors.fill: parent

        ListView {
            id: listView
            Layout.preferredWidth: 150
            Layout.fillHeight: true
            currentIndex: -1

            model: ListModel {
                ListElement { title: "Hello QML"; source: "qrc:/qml/HelloPage.qml" }
                ListElement { title: "Rectangle"; source: "qrc:/qml/RectanglePage.qml" }
                ListElement { title: "Text"; source: "qrc:/qml/TextPage.qml" }
                ListElement { title: "Image"; source: "qrc:/qml/ImagePage.qml" }
                ListElement { title: "Layout"; source: "qrc:/qml/LayoutPage.qml" }
                ListElement { title: "Color"; source: "qrc:/qml/ColorPage.qml" }
                ListElement { title: "Mouse Events"; source: "qrc:/qml/MouseEventsPage.qml" }
                ListElement { title: "Key Events"; source: "qrc:/qml/KeyEventsPage.qml" }
                ListElement { title: "Timer"; source: "qrc:/qml/TimerPage.qml" }
                ListElement { title: "Z-Order"; source: "qrc:/qml/ZOrderPage.qml" }
                ListElement { title: "Compontent"; source: "qrc:/qml/CompontentPage.qml" }
                ListElement { title: "Inline Compontent"; source: "qrc:/qml/InlineCompontentPage.qml" }
                ListElement { title: "Inline Compontent"; source: "qrc:/qml/InlineCompontentPage.qml" }
                ListElement { title: "Canvas"; source: "qrc:/qml/CanvasPage.qml" }
                ListElement { title: "Canva(Image)"; source: "qrc:/qml/CanvasImagePage.qml" }
                ListElement { title: "Canva(Text)"; source: "qrc:/qml/CanvasTextPage.qml" }
                ListElement { title: "Canva(Gradient)"; source: "qrc:/qml/CanvasGradientPage.qml" }
                ListElement { title: "Canva(ImageData)"; source: "qrc:/qml/CanvasImageDataPage.qml" }
                ListElement { title: "Canva(Clip)"; source: "qrc:/qml/CanvasClipPage.qml" }
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
