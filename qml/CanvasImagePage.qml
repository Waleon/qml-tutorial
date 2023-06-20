/****************************************
* @brief    QML Canvas 元素（绘制图像）
* @blog     https://waleon.blog.csdn.net/article/details/131317973
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick
import QtQuick.Layouts

// Canvas - 绘制图像
Rectangle {
    id: canvasImagePage

    // 绘制边框，更容易看出效果
    function drawBorder(ctx) {
        ctx.save()
        ctx.strokeStyle = "lightgray"
        ctx.beginPath()
        ctx.strokeRect(0, 0, ctx.canvas.width, ctx.canvas.height)
        ctx.restore()
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Item {
            Layout.fillWidth: true
        }

        // 1. 在画布的指定点绘制整张图片
        Canvas {
            width: 200; height: 200

            property string img: "qrc:/images/logo.jpg"

            onPaint: {
                var ctx = getContext("2d")

                canvasImagePage.drawBorder(ctx)

                // 绘制图片
                ctx.drawImage(img, 100, 100)
            }

            // 图片加载完成时，重绘 Canvas
            onImageLoaded: requestPaint()

            // 在附加处理器中加载图片
            Component.onCompleted: loadImage(img)
        }

        // 2. 在画布上指定位置和区域绘制整张图片
        Canvas {
            width: 200; height: 200

            property string img: "qrc:/images/logo.jpg"

            onPaint: {
                var ctx = getContext("2d")

                canvasImagePage.drawBorder(ctx)

                // 绘制图片（起点坐标、绘制区域）
                ctx.drawImage(img, 50, 50, 80, 120)
            }

            onImageLoaded: requestPaint()
            Component.onCompleted: loadImage(img)
        }

        // 3. 截取图片的一部分绘制到画布上
        Canvas {
            id:cans
            width: 200; height: 200

            property string img: "qrc:/images/logo.jpg"

            onPaint: {
                var ctx = getContext("2d")

                canvasImagePage.drawBorder(ctx)

                // 绘制图片（图像截取区域、画布绘制区域）
               ctx.drawImage(img, 20, 20, 80, 80, 50, 50, 80, 120)
            }

            onImageLoaded: requestPaint()
            Component.onCompleted: loadImage(img)
        }

        // 4. 其他绘图方式（Image 元素）
        Canvas {
            width: 200; height: 200

            Image {
                id: image
                source: "qrc:/images/logo.jpg"
                visible: false  // 先将其隐藏
            }

            onPaint: {
                var ctx = getContext("2d")

                canvasImagePage.drawBorder(ctx)

                // 绘制图片
                ctx.drawImage(image, 100, 100)
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
