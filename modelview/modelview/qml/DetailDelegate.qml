import QtQuick
import QtQuick.Layouts

Item {
    width: 150; height: 25

    RowLayout {
        anchors.fill: parent
        spacing: 10

        Image {
            source: model.portrait  // 头像
            sourceSize: Qt.size(16, 16)
        }
        Text {
            text: model.name        // 名字
        }
        Text {
            text: model.number      // 号码
        }
    }
}
