import QtQuick
import QtQuick.Layouts

Item {
    width: 100; height: 100

    ColumnLayout {
        anchors.fill: parent
        Item {
            Layout.fillHeight: true
        }
        Image {
            source: model.portrait  // 头像
            sourceSize: Qt.size(50, 50)
            Layout.alignment: Qt.AlignCenter
        }
        Text {
            text: model.name        // 名字
            Layout.alignment: Qt.AlignCenter
        }
        Item {
            Layout.fillHeight: true
        }
    }
}
