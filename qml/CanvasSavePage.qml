/****************************************
* @brief    QML Canvas 保存画布内容
* @blog     https://waleon.blog.csdn.net/article/details/131537197
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick
import QtQuick.Layouts

Rectangle {
    id: canvasSavePage

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Item {
            Layout.fillWidth: true
        }

        // 1. 点击鼠标，显示图像数据并进行打印
        Image {
            id: image
            width: canvas.width
            height: canvas.height
        }

        Canvas {
            id: canvas
            width: 200; height: 200

            onPaint: {
                var ctx = getContext("2d")
                ctx.fillStyle = "green"
                ctx.fillRect(0, 0, width, height)
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    // 打印画布内容并用 Image 组件显示
                    var dataUrl = canvas.toDataURL()
                    image.source = dataUrl
                    console.info("dataUrl:" + dataUrl)
                }
            }
        }

        // 2. 点击鼠标保存图片
        Canvas {
            id: canvas2
            width: 200; height: 200

            onPaint: {
                var ctx = getContext("2d")
                ctx.fillStyle = "green"
                ctx.fillRect(0, 0, width, height)
            }

            MouseArea {
                anchors.fill: parent
                // 点击鼠标保存图片
                onClicked: {
                    if (canvas2.save("canvas2.png", Qt.size(150, 150))) {
                        console.info("save successfully")
                    } else {
                        console.info("save failure")
                    }
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
