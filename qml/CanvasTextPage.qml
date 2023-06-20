import QtQuick
import QtQuick.Layouts

// Canvas - 绘制文本
Rectangle {
    id: canvasTextPage

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

        // 1. 绘制文本
        Canvas {
            width: 200; height: 200

            onPaint: {
                var ctx = getContext("2d")

                canvasTextPage.drawBorder(ctx)

                // 填充文本
                ctx.fillText("Hello, Canvas!", 10, 100)
            }
        }

        // 2. 设置字体
        Canvas {
            width: 300; height: 400

            onPaint: {
                var ctx = getContext("2d")

                canvasTextPage.drawBorder(ctx)

                // 设置字体
                var fontFamily = "px sans-serif"

                for (var i = 10; i <= 24; i++) {
                    ctx.font = i + fontFamily;
                    ctx.fillText(i + "px: " + "Hello, Canvas!", 10, 30*(i-9));
                }
            }
        }

        // 3. 设置样式
        Canvas {
            width: 200; height: 200

            onPaint: {
                var ctx = getContext("2d")

                canvasTextPage.drawBorder(ctx)

                ctx.font = "24px sans-serif"

                // 设置填充样式、线条样式
                ctx.lineWidth = 1
                ctx.strokeStyle = "red"
                ctx.fillStyle = "green"

                // 填充文本
                ctx.fillText("Fill", 10, 50)

                // 为文本描边（无填充）
                ctx.strokeText("Stroke", 10, 100)

                // 填充文本并描边
                ctx.text("Stroke and Fill", 10, 150)
                ctx.fill()
                ctx.stroke()
            }
        }

        // 4. 文本基线（垂直对齐）
        ColumnLayout {
            anchors.margins: 10
            spacing: 10

            Item {
                Layout.fillHeight: true
            }

            Canvas {
                width: 200; height: 100

                onPaint: {
                    var ctx = getContext("2d")

                    canvasTextPage.drawBorder(ctx)

                    ctx.font = "24px sans-serif"
                    ctx.fillText("Hello, Canvas!", 0, 0)
                    ctx.fillText("Hello, Canvas!", 0, 50)
                    ctx.moveTo(0, 50)
                    ctx.lineTo(200, 50)
                    ctx.strokeStyle = "red"
                    ctx.stroke()
                }
            }

            // 六线五格：指定一个文本和绘制点之间的关系
            Canvas {
                width: 200; height: 100

                onPaint: {
                    var ctx = getContext("2d")

                    canvasTextPage.drawBorder(ctx)

                    ctx.font = "24px sans-serif"
                    // 设置基线在文本的顶部
                    ctx.textBaseline = "top";
                    ctx.fillText("Hello, Canvas!", 0, 0)
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }

        // 5. 水平对齐
        Canvas {
            width: 200; height: 200

            onPaint: {
                var ctx = getContext("2d")

                canvasTextPage.drawBorder(ctx)

                // 水平对齐方式（默认值：start）
                var textAlign = ['left', 'right', 'center', 'start', 'end']

                // 绘制一条“基准线”
                ctx.strokeStyle = "red"
                ctx.moveTo(100, 0)
                ctx.lineTo(100, 200)
                ctx.stroke()

                // 设置文本色并绘制文本
                ctx.font = "24px sans-serif"
                ctx.fillStyle= "black"

                for (var i = 0; i < textAlign.length; i++) {
                    ctx.textAlign = textAlign[i]
                    ctx.fillText(textAlign[i], 100, 40*(i+1))
                }
            }
        }

        // 6.计算文本宽度（显示省略号）
        Canvas {
            width: 200; height: 200

            onPaint: {
                var ctx = getContext("2d")

                canvasTextPage.drawBorder(ctx)

                ctx.font = "20px sans-serif"
                var text = "This is a very very very very very long text."
                var measure = ctx.measureText(text)

                // 当文本宽度大于画布宽度时，显示省略号
                if (measure.width > width) {
                    var ellipses = "..."
                    while (text.length > 0 && measure.width + ctx.measureText(ellipses).width > width) {
                        // 剔除最后一个字符后进行提取
                        text = text.slice(0, -1)
                        measure = ctx.measureText(text)
                    }
                    text += ellipses
                }
                ctx.fillText(text, 0, 20)
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
