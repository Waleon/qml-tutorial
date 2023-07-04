/****************************************
* @brief    QML Canvas 渐变和阴影
* @blog     https://waleon.blog.csdn.net/article/details/131394488
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick
import QtQuick.Layouts

Rectangle {
    id: canvasGradientPage

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Item {
            Layout.fillWidth: true
        }

        // 1.1 线性渐变
        Canvas {
            width: 200; height: 200

            onPaint: {
                var ctx = getContext("2d")
                // 从左向右渐变
                var gradient = ctx.createLinearGradient(0, 0, width, 0)
                gradient.addColorStop(0.0, "yellow")  // 最左侧，黄色
                gradient.addColorStop(1.0, "green")   // 最右侧，绿色
                ctx.fillStyle = gradient
                ctx.beginPath()
                ctx.fillRect(0, 0, width, height)
            }
        }

        // 1.2 辐射渐变
        Canvas {
            width: 200; height: 200

            onPaint: {
                var ctx = getContext("2d")
                // 从 (100, 100) 到 (100, 100) 的颜色辐射，起始半径为 10，结束半径为 100
                var gradient = ctx.createRadialGradient(100, 100, 10, 100, 100, 100)
                gradient.addColorStop(0.0, "green")  // 起始圆，绿色
                gradient.addColorStop(1.0, "white")  // 结束圆，白色
                ctx.fillStyle = gradient
                ctx.beginPath()
                ctx.fillRect(0, 0, width, height)
            }
        }

        // 1.3 锥形渐变
        Canvas {
            width: 200; height: 200

            onPaint: {
                var ctx = getContext("2d")
                // 绕着中心点（100，100）从 0 弧度处开始沿逆时针方向旋转
                var gradient = ctx.createConicalGradient(100, 100, 0)
                gradient.addColorStop(0.0, "yellow")  // 在 0 度处，黄色
                gradient.addColorStop(0.5, "green")   // 在 180 度处，绿色
                gradient.addColorStop(1.0, "white")  // 在 360 度处，白色
                ctx.fillStyle = gradient
                ctx.beginPath()
                ctx.fillRect(0, 0, width, height)
            }
        }

        // 2.1 阴影
        Canvas {
            width: 200; height: 200

            // 绘制一个带有黑色阴影的绿色矩形，模糊级别是 10
            function drawRect(ctx) {
                ctx.fillStyle = "green"
                ctx.shadowColor = "black"
                ctx.shadowBlur = 10
                ctx.beginPath()
                ctx.fillRect(20, 20, 160, 160)
            }

            // 绘制一个带有黑色阴影的白色文本，模糊级别是 2
            function drawText(ctx, text) {
                ctx.font = "48px sans-serif"

                // 水平居中
                var measure = ctx.measureText(text)
                var x = (width - measure.width) / 2

                // 垂直居中
                ctx.textBaseline = "middle"
                var y = height / 2

                ctx.fillStyle = "white"
                ctx.shadowColor = "black"
                ctx.shadowBlur = 2
                ctx.shadowOffsetX = 5
                ctx.shadowOffsetY = 5
                ctx.fillText(text, x, y)
            }

            onPaint: {
                var ctx = getContext("2d")

                drawRect(ctx)
                drawText(ctx, "QML")
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }
}


