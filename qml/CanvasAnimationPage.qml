/****************************************
* @brief    QML Canvas 制作动画
* @blog     https://waleon.blog.csdn.net/article/details/131581909
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick
import QtQuick.Layouts
import "qrc:/js/utils.js" as Utils

// Canvas - 动画
Rectangle {
    id: canvasAnimationPage

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Item {
            Layout.fillWidth: true
        }

        // 灵动的小球
        Canvas {
            id: canvas
            width: 300; height: 150

            property int handle

            // 定义圆球
            QtObject {
                id: ball

                property bool isRunning: true

                // 初始位置和半径（左上角）
                property int x: radius
                property int y: radius
                property int radius: 12
                property color background: "green"

                // 速度
                property int speedX: 1
                property int speedY: 2

                // 更新位置
                function updatePosition() {
                    x += speedX
                    y += speedY

                    // 边界检测
                    if (x - radius < 0) {
                        x = radius
                        speedX = -speedX
                    }

                    if (x + radius > canvas.width) {
                        x = canvas.width - radius
                        speedX = -speedX
                    }

                    if (y - radius < 0) {
                        y = radius
                        speedY = -speedY
                    }

                    if (y + radius > canvas.height) {
                        y = canvas.height - radius
                        speedY = -speedY
                    }
                }
            }

            onPaint: {
                updateAnimation()
            }

            // 绘制圆球
            function drawBall() {
                var ctx = canvas.getContext("2d")

                // 清空画布
                ctx.clearRect(0, 0, canvas.width, canvas.height)

                Utils.drawBorder(ctx)

                ctx.beginPath()
                ctx.arc(ball.x, ball.y, ball.radius, 0, 2 * Math.PI)
                ctx.fillStyle = ball.background
                ctx.fill()
                ctx.closePath()
            }

            function updateAnimation() {
                // 更新动画状态
                ball.updatePosition()

                // 绘制圆球
                drawBall()

                // 请求下一帧动画
                handle = requestAnimationFrame(updateAnimation)
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (ball.isRunning) {
                        canvas.cancelRequestAnimationFrame(canvas.handle)
                    } else {
                        canvas.handle = canvas.requestAnimationFrame(canvas.updateAnimation)
                    }
                    ball.isRunning = !ball.isRunning
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }
}


