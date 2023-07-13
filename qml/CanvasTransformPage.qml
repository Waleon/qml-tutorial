import QtQuick
import QtQuick.Layouts
import "qrc:/js/utils.js" as Utils

// Canvas - 几何变换（平移、旋转、缩放）
Rectangle {
    id: canvasTransformPage

    function drawCoordinate(ctx) {
        for (var j = 0; j < ctx.canvas.height; j += 10) {
            ctx.strokeStyle = Qt.rgba(0, 0, 1, 0.2)
            ctx.beginPath()
            ctx.moveTo(0, j)
            ctx.lineTo(width, j)
            ctx.stroke()
        }

        for (var i = 0; i < ctx.canvas.width; i += 10) {
            ctx.strokeStyle = Qt.rgba(0, 0, 1, 0.2)
            ctx.beginPath()
            ctx.moveTo(i, 0)
            ctx.lineTo(i, height)
            ctx.stroke()
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Item {
            Layout.fillWidth: true
        }

        // 1. 保存和恢复绘图上下文的状态
        Canvas {
            width: 200; height: 200

            onPaint: {
                var ctx = getContext("2d")

                Utils.drawBorder(ctx)

                // 保存绘图上下文的状态
                ctx.save()

                // 绘制操作
                ctx.fillStyle = "green"
                ctx.fillRect(10, 10, 80, 80)

                // 恢复绘图上下文的状态
                ctx.restore()

                // 再次绘制
                ctx.fillRect(110, 110, 80, 80)
            }
        }

        // 2. 平移
        Canvas {
            width: 200; height: 200

            onPaint: {
                var ctx = getContext("2d")

                Utils.drawBorder(ctx)

                ctx.fillStyle = "blue"
                ctx.fillRect(10, 10, 80, 80)

                // 将原点从平移到 (100, 100)
                ctx.translate(100, 100)

                ctx.fillStyle = "green"
                ctx.fillRect(10, 10, 80, 80)
            }
        }

        // 3. 旋转
        Canvas {
            width: 200; height: 200

            // 左侧矩形, 从画布原点旋转
            function drawLeft(ctx) {
                ctx.save()
                // 蓝色矩形
                ctx.fillStyle = "blue"
                ctx.fillRect(10, 10, 80, 80)

                // 旋转 45 度
                ctx.rotate(Math.PI / 4)

                // 绿色矩形
                ctx.fillStyle = "green"
                ctx.fillRect(10, 10, 80, 80)
                ctx.restore()
            }

            // 右侧矩形, 从矩形中心点旋转
            function drawRight(ctx) {
                ctx.save()
                // 蓝色矩形
                ctx.fillStyle = "blue"
                ctx.fillRect(100, 100, 80, 80)

                // 平移到矩形中心点
                // centerX = x + 0.5 * width
                // centerY = y + 0.5 * height
                ctx.translate(140, 140)
                // 旋转 45 度
                ctx.rotate(Math.PI / 4)
                // 再平移回去
                ctx.translate(-140, -140)

                // 绿色矩形
                ctx.fillStyle = "green"
                ctx.fillRect(100, 100, 80, 80)
                ctx.restore()
            }

            onPaint: {
                var ctx = getContext("2d")

                Utils.drawBorder(ctx)

                drawLeft(ctx)
                drawRight(ctx)
            }
        }

        // 4. 缩放
        Canvas {
            width: 200; height: 200

            onPaint: {
                var ctx = getContext("2d")

                Utils.drawBorder(ctx)

                ctx.fillStyle = "blue"
                ctx.fillRect(10, 10, 80, 80)

                ctx.save()
                ctx.scale(2.0, 2.0)
                ctx.fillStyle = "green"
                ctx.fillRect(10, 10, 80, 80)
                ctx.restore()
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
