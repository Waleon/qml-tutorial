/****************************************
* @brief    QML Image 元素
* @blog     https://waleon.blog.csdn.net/article/details/131197531
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    id: imagePage

    Column {
        anchors.horizontalCenter: imagePage.horizontalCenter
        anchors.verticalCenter: imagePage.verticalCenter
        spacing: 10

        // 1. 基本用法
        Image {
            source: "qrc:/images/logo.jpg"
        }

        // 2. 控制显示图像的大小
        Image {
            width: 100
            height: 100
            source: "qrc:/images/logo.jpg"
        }

        // 3. 控制加载图像的尺寸
        Image {
            source: "qrc:/images/logo.jpg"
            sourceSize: Qt.size(100, 100)
        }

        // 4. 图像镜像
        Row {
            spacing: 10

            // 水平反转
            Image {
                source: "qrc:/images/logo.jpg"
                mirror: true
            }

            // 垂直反转
            Image {
                source: "qrc:/images/logo.jpg"
                mirrorVertically: true
            }
        }

        // 5. 填充模式
        Row {
            spacing: 10
            Image {
                width: 120; height: 80
                source: "qrc:/images/logo.jpg"
            }
            Image {
                width: 120; height: 80
                source: "qrc:/images/logo.jpg"
                fillMode: Image.PreserveAspectFit
            }
            Image {
                width: 120; height: 80
                source: "qrc:/images/logo.jpg"
                fillMode: Image.PreserveAspectCrop
            }
            Image {
                width: 150; height: 150
                source: "qrc:/images/logo.jpg"
                fillMode: Image.Tile
                horizontalAlignment: Image.AlignLeft
                verticalAlignment: Image.AlignTop
            }
            Image {
                width: 150; height: 150
                source: "qrc:/images/logo.jpg"
                fillMode: Image.TileVertically
                verticalAlignment: Image.AlignTop
            }
            Image {
                width: 150; height: 150
                source: "qrc:/images/logo.jpg"
                fillMode: Image.TileHorizontally
                horizontalAlignment: Image.AlignLeft
            }
        }

        // 5. 网络图片
        Rectangle {
            width: 100
            height: 100
            color: "gray"

            Image {
                id: image
                anchors.fill: parent
                // 是否缓存
                cache: false
                // 网络加载总是异步的，无需指定
                // asynchronous: true

                // 显示加载状态
                onStatusChanged: {
                    if (image.status === Image.Loading) {
                        console.info("loding....");
                    } else if (image.status === Image.Ready) {
                        console.info("ready....");
                    } else if (image.status === Image.Error) {
                        console.info("error....");
                    } else {
                        console.info("status:" + image.status);
                    }
                }
            }

            // 点击鼠标，加载图片
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    image.source = "https://img-blog.csdn.net/20181012203708165"
                }
            }
        }
    }
}
