/****************************************
* @brief    QML Canvas 像素处理
* @blog     https://waleon.blog.csdn.net/article/details/131435731
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick
import QtQuick.Layouts
import "qrc:/js/utils.js" as Utils

Rectangle {
    id: canvasImageDataPage

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Item {
            Layout.fillWidth: true
        }

        // 1. 创建指定尺寸的 CanvasImageData 对象
        Canvas {
            width: 200; height: 200

            onPaint: {
                var ctx = getContext("2d")

                Utils.drawBorder(ctx)

                // 创建一个 1 x 1 大小的透明的像素数据
                var imageData = ctx.createImageData(1, 1)
                // 图像的总通道数
                var channels = imageData.data.length

                ctx.font = "14px sans-serif"
                ctx.textBaseline = "top"

                ctx.fillText("imageData width:" + imageData.width, 10, 10)
                ctx.fillText("imageData height:" + imageData.height, 10, 30)
                ctx.fillText("imageData channels:" + channels, 10, 50)

                // 遍历每一个像素
                for (var i = 0; i < channels; i += 4) {
                    var r = imageData.data[i]    // 获取 r 值
                    var g = imageData.data[i+1]  // 获取 g 值
                    var b = imageData.data[i+2]  // 获取 b 值
                    var a = imageData.data[i+3]  // 获取 alpha 值

                    var spacing = (i / 4) * 20
                    ctx.fillText("pixel(%1):(r:%2, g:%3, b:%4, a:%5)".arg(i/4+1).arg(r).arg(g).arg(b).arg(a), 10, 70 + spacing)
                }
            }
        }

        // 2. 填充像素数据，并将其绘制到画布上
        Canvas {
            id: canvas
            width: 200; height: 200

            // 产生 [0, 255] 随机数（random 范围 [0, 1)）
            function randomNum() {
                return Math.floor(Math.random() * 256)
            }

            // 产生一个随机色
            function randomColor() {
                return {r: randomNum(), g: randomNum(), b: randomNum(), a: randomNum()}
            }

            // 利用随机色填充像素数据
            function fillData(imageData) {
                var channels = imageData.data.length
                var color = randomColor()
                for (var i = 0; i < channels; i += 4) {
                    imageData.data[i]   = color.r  // 设置 r 值
                    imageData.data[i+1] = color.g  // 设置 g 值
                    imageData.data[i+2] = color.b  // 设置 b 值
                    imageData.data[i+3] = color.a  // 设置 alpha 值
                }
            }

            onPaint: {
                var ctx = getContext("2d")

                ctx.clearRect(0, 0, width, height)
                var imageData = ctx.createImageData(width, height)
                fillData(imageData)
                ctx.putImageData(imageData, 0, 0, 0, 0, imageData.width, imageData.height)
            }

            MouseArea {
                anchors.fill: parent
                onClicked: canvas.requestPaint()
            }
        }

        // 3. 通过 Url 创建 CanvasImageData 对象
        Canvas {
            width: 400; height: 200

            property string img: "qrc:/images/logo.jpg"

            // 灰度处理（加权平均值法）
            function grayscale(imageData) {
                var channels = imageData.data.length;

                for (var i = 0; i < channels; i += 4) {
                    var r = imageData.data[i]
                    var g = imageData.data[i+1]
                    var b = imageData.data[i+2]

                    var avg = 0.3*r + 0.59*g + 0.11*b

                    imageData.data[i] = avg    // 设置 r 值
                    imageData.data[i+1] = avg  // 设置 g 值
                    imageData.data[i+2] = avg  // 设置 b 值
                }
            }

            onPaint: {
                var ctx = getContext("2d")

                Utils.drawBorder(ctx)

                // 原图和处理后的图像做对比
                var imageData = ctx.createImageData(img)
                var newImageData = ctx.createImageData(img)
                grayscale(newImageData)
                ctx.drawImage(imageData, 10, 10, 180, 180)
                ctx.drawImage(newImageData, 210, 10, 180, 180)
            }

            onImageLoaded: requestPaint()
            Component.onCompleted: loadImage(img)
        }

        // 4. 从画布的指定区域获取 CanvasImageData 对象
        Canvas {
            width: 200; height: 200

            property string img: "qrc:/images/logo.jpg"

            onPaint: {
                var ctx = getContext("2d")

                Utils.drawBorder(ctx)

                ctx.fillStyle = "green"
                ctx.beginPath()
                ctx.fillRect(0, 0, 100, 100)

                ctx.drawImage(img, 100, 0, 100, 100)

                // 从坐标点 (50, 20) 处开始，获取宽高为 100 x 60 区域内的像素数据
                var imageData = ctx.getImageData(50, 20, 100, 60)
                ctx.drawImage(imageData, 0, 120)
            }

            onImageLoaded: requestPaint()
            Component.onCompleted: loadImage(img)
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
