/****************************************
* @brief    QML Canvas 绘制文本
* @blog     https://waleon.blog.csdn.net/article/details/131344711
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick
import QtQuick.Layouts

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
            width: 300; height: 500

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
            width: 250; height: 200

            onPaint: {
                var ctx = getContext("2d")

                canvasTextPage.drawBorder(ctx)

                ctx.font = "36px sans-serif"

                // 填充文本
                ctx.fillStyle = "green"
                ctx.fillText("Fill", 10, 50)

                // 文本描边（无填充）
                ctx.lineWidth = 1
                ctx.strokeStyle = "red"
                ctx.strokeText("Stroke", 10, 100)

                // 填充文本并描边
                ctx.text("Fill & Stroke", 10, 150)
                ctx.fill()
                ctx.stroke()
            }
        }

        // 4.计算文本宽度（显示省略号）
        Canvas {
            width: 200; height: 200

            onPaint: {
                var ctx = getContext("2d")

                canvasTextPage.drawBorder(ctx)

                ctx.font = "16px sans-serif"

                // 预测文本宽度
                var measure = ctx.measureText("Hello, Canvas!");
                ctx.fillText("'Hello, Canvas!' width:" + measure.width, 10, 100);
            }
        }

        // 5. 文本基线（垂直对齐）
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

                    ctx.font = "16px sans-serif"

                    ctx.fillText("Hello, Canvas!", 0, 0)
                }
            }

            // 文本基线在文本的顶部
            Canvas {
                width: 200; height: 100

                onPaint: {
                    var ctx = getContext("2d")

                    canvasTextPage.drawBorder(ctx)

                    ctx.font = "16px sans-serif"
                    // 设置基线在文本的顶部
                    ctx.textBaseline = "top"
                    ctx.fillText("Hello, Canvas!", 0, 0)
                }
            }

            // 六线五格：指定一个文本和绘制点之间的关系
            Canvas {
                width: 450; height: 200

                onPaint: {
                    var ctx = getContext("2d")

                    canvasTextPage.drawBorder(ctx)

                    ctx.font = "16px sans-serif"

                    // 基线（默认值：alphabetic）
                    var textBaseline = ['top', 'hanging', 'middle', 'alphabetic', 'ideographic', 'bottom']

                    // 画一条蓝线（以确定绘制点与基线的位置）
                    ctx.strokeStyle = "blue"
                    ctx.moveTo(0, 100)
                    ctx.lineTo(450, 100)
                    ctx.stroke()

                    var x = 10

                    for (var i = 0; i < textBaseline.length; i++) {
                        ctx.textBaseline = textBaseline[i]
                        ctx.fillText(textBaseline[i], x, 100)

                        // 根据当前文本的宽度，计算下一个文本的 x 坐标
                        var measure = ctx.measureText(textBaseline[i])
                        x = x + measure.width + 10
                    }
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }

        // 8. 水平对齐
        Canvas {
            width: 200; height: 200

            onPaint: {
                var ctx = getContext("2d")

                canvasTextPage.drawBorder(ctx)

                // 水平对齐方式（默认值：start）
                var textAlign = ['left', 'right', 'center', 'start', 'end']

                // 绘制一条“基准线”
                ctx.strokeStyle = "blue"
                ctx.moveTo(100, 0)
                ctx.lineTo(100, 200)
                ctx.stroke()

                // 绘制文本
                ctx.font = "16px sans-serif"

                for (var i = 0; i < textAlign.length; i++) {
                    ctx.textAlign = textAlign[i]
                    ctx.fillText(textAlign[i], 100, 40*(i+1))
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
