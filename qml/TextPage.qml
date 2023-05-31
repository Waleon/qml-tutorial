import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

// 文本、标签
Rectangle {
    id: textPage

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        // 1. 基础文本
        Text {
            text: qsTr("Hello World!")  // 文本
            color: "blue"  // 颜色
        }

        // 2. 文本字体
        Text {
            text: qsTr("Hello World!")

            font {
                family: "Helvetica"  // 字体
                pointSize: 20  // 字体大小
                bold: true    // 粗体
                italic: true  // 斜体
                underline: true  // 下划线
                capitalization: Font.AllLowercase   // 大小写（文本自动转小写）
            }
        }

        // 3. 文本格式
        // 纯文本
        Text {
            textFormat: Text.PlainText
            text: "<b>Hello</b> <i>World!</i>"
        }

        // 富文本
        Text {
            textFormat: Text.RichText
            text: "<b>Hello</b> <i>World!</i>"
        }

        // 显示图片
        Text {
            text: "<img src=\"qrc:/images/images/logo.jpg\" width=\"200\" height=\"200\">"
        }

        // 4. 长文本
        ColumnLayout {
            // 文本截断
            Text {
                id: longText
                Layout.preferredWidth: 150
                clip: true
                text: "One, two and three miles to go; Four or five hamlets in haze. Six, seven arbors or so; Eight, nine and ten budding sprays."
            }

            // 文本省略（超出部分显示为省略号）
            Text {
                Layout.preferredWidth: 150
                elide: Text.ElideRight
                text: longText.text
            }

            // 文本换行（自动换行）
            Text {
                Layout.preferredWidth: 150
                wrapMode: Text.WordWrap
                text: longText.text
            }
        }

        // 5. 文本样式
        RowLayout {
            spacing: 10
            Text { font.pointSize: 24; text: "Normal" }
            Text { font.pointSize: 24; text: "Raised"; style: Text.Raised; styleColor: "red" }
            Text { font.pointSize: 24; text: "Outline"; style: Text.Outline; styleColor: "red" }
            Text { font.pointSize: 24; text: "Sunken"; style: Text.Sunken; styleColor: "red" }
        }

        // 6. 超链接
        Text {
            linkColor: "green"  // 超链接颜色
            text: "See the <a href=\"https://waleon.blog.csdn.net\">Waleon blog</a>."
            onLinkHovered: console.info(link + " link hovered")
            onLinkActivated: {
                Qt.openUrlExternally(link)
                console.info(link + " link activated")
            }
        }

        // 7. 文本背景（包含样式风格）
        Label {
            text: qsTr("Hello World!")
            color: "white"

            background: Rectangle {
                color: "green"
            }
        }

        // 圆形背景
        Label {
            Layout.preferredWidth: 100
            Layout.preferredHeight: 100
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment : Text.AlignVCenter
            text: qsTr("Hello World!")
            color: "white"

            background: Rectangle {
                color: "green"
                radius: 50
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
