/****************************************
* @brief    QML Canvas 裁剪
* @blog     https://waleon.blog.csdn.net/article/details/131472181
* @author   一去、二三里
* @wechat   iwaleon
* 微信公众号  高效程序员
****************************************/

import QtQuick
import QtQuick.Layouts

Rectangle {
    id: canvasClipPage

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Item {
            Layout.fillWidth: true
        }

        // 1. 圆形图像
        Canvas {
            width: 200; height: width

            property string img: "qrc:/images/logo.jpg"

            onPaint: {
                var ctx = getContext("2d")

                // 创建裁剪区域
                ctx.beginPath()
                ctx.arc(width/2, height/2, width/2, 0, 2*Math.PI)
                ctx.clip()

                // 在裁剪区域内绘制内容
                ctx.drawImage(img, 0, 0, width, height)
            }

            onImageLoaded: requestPaint()
            Component.onCompleted: loadImage(img)
        }

        // 2. 五角星图像
        Canvas {
            width: 200; height: width

            property string img: "qrc:/images/logo.jpg"

            onPaint: {
                var ctx = getContext("2d")

                ctx.strokeStyle = "blue"

                // 创建五角星裁剪区域
                star(ctx, width/2, height/2, width/2, width/4, 0)
                ctx.stroke()
                ctx.clip()

                ctx.drawImage(img, 0, 0, width, height)
            }

            // (x, y)：圆心
            // R：外圆半径
            // r：内圆半径
            // rot：顺时针旋转的角度
            // 将度换算成弧度：度数乘以 π/180（注意：360°=2π）
            function star(cxt, x, y, R, r, rot) {
                cxt.beginPath()
                for (var i = 0; i < 5; i++) {
                    cxt.lineTo(x + Math.cos((18 + i * 72 - rot) / 180 * Math.PI) * R,
                               y - Math.sin((18 + i * 72- rot) / 180 * Math.PI) * R)
                    cxt.lineTo(x + Math.cos((54 + i * 72 - rot) / 180 * Math.PI) * r,
                               y - Math.sin((54 + i * 72 - rot) / 180 * Math.PI) * r)
                }
                cxt.closePath()
            }

            onImageLoaded: requestPaint()
            Component.onCompleted: loadImage(img)
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
