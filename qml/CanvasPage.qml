/****************************************
* @brief    QML Canvas 绘制点线面
* @blog     https://waleon.blog.csdn.net/article/details/131254637
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick
import QtQuick.Layouts

Rectangle {
    id: canvasPage

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

        // 1. 绘制点
        Canvas {
            width: 150; height: 150

            // 事件处理程序，在绘图（更新）时触发
            onPaint: {
                // 使用 Context2D 对象来绘图
                var ctx = getContext("2d");

                canvasPage.drawBorder(ctx)

                // 设置填充色为红色
                ctx.fillStyle = "red"

                // 新建一条路径
                ctx.beginPath()
                // 以 (75, 75) 为圆心，5 为半径，画一个从 0-2π 的圆
                ctx.arc(75, 70, 5, 0, 2*Math.PI)
                // 填充该圆点的颜色
                ctx.fill()
            }
        }

        // 2. 绘制直线
        Canvas {
            width: 150; height: 150

            onPaint: {
                var ctx = getContext("2d")

                canvasPage.drawBorder(ctx)

                // 设置线条的宽度为 2，颜色为绿色
                ctx.lineWidth = 2
                ctx.strokeStyle = "green"

                // 新建一条路径
                ctx.beginPath()
                // 定义直线的起点和终点
                ctx.moveTo(30, 30)
                ctx.lineTo(100, 100)
                // 渲染路径并描绘出直线
                ctx.stroke()
            }
        }

        // 3. 绘制曲线
        Canvas {
            width: 150; height: 150

            onPaint: {
                var ctx = getContext("2d")

                canvasPage.drawBorder(ctx)

                // 设置线条的宽度为 2，颜色为蓝色
                ctx.lineWidth = 2
                ctx.strokeStyle = "blue"

                // 开启路径
                ctx.beginPath()
                // 指定曲线的起点、控制点和终点
                ctx.moveTo(10, 75)
                ctx.quadraticCurveTo(75, 0, 140, 75)
                // 渲染路径并描绘出曲线
                ctx.stroke()
            }
        }

        // 4. 绘制矩形
        Canvas {
            width: 150; height: 150

            // 绘制实心矩形
            function drawSolidRect(ctx) {
                // 设置填充色为橙色
                ctx.fillStyle = "orange"

                ctx.beginPath()
                ctx.rect(10, 10, 60, 60)
                ctx.fill() // 填充矩形
            }

            // 绘制空心矩形
            function drawHollowRect(ctx) {
                // 设置线条的宽度为 2，颜色为黑色
                ctx.lineWidth = 2
                ctx.strokeStyle = "black"

                ctx.beginPath()
                ctx.rect(80, 10, 60, 60)
                ctx.stroke() // 为矩形描边
            }

            // 绘制带边框的实心矩形
            function drawBorderSolidRect(ctx) {
                ctx.fillStyle = "orange"
                ctx.lineWidth = 2
                ctx.strokeStyle = "black"

                ctx.beginPath()
                ctx.rect(10, 80, 130, 60)
                // 填充 + 描边
                ctx.fill()
                ctx.stroke()
            }

            onPaint: {
                var ctx = getContext("2d")

                canvasPage.drawBorder(ctx)

                drawSolidRect(ctx)
                drawHollowRect(ctx)
                drawBorderSolidRect(ctx)
            }
        }

        // 5. 绘制椭圆
        Canvas {
            width: 150; height: 150

            onPaint: {
                var ctx = getContext("2d")

                canvasPage.drawBorder(ctx)

                // 绘制实心椭圆
                ctx.fillStyle = "orange"
                ctx.beginPath()
                // 椭圆：左上角(x, y)、宽高(w, h)
                ctx.ellipse(10, 20, 130, 100)
                ctx.fill()
            }
        }

        // 6. 绘制圆形
        Canvas {
            width: 150; height: 150

            onPaint: {
                var ctx = getContext("2d")

                canvasPage.drawBorder(ctx)

                // 绘制实心圆
                ctx.fillStyle = "orange"
                ctx.beginPath()
                // 以 (75, 75) 为圆心，60 为半径，画一个从 0-2π 的圆
                ctx.arc(75, 75, 60, 0, 2*Math.PI)
                ctx.fill()
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
