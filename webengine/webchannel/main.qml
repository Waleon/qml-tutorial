import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtWebEngine
import QtWebChannel

Window {
    width: 800
    height: 600
    visible: true

    // 发布至 Web 端的对象
    QtObject {
        id: object

        // 指定标识符，Web 端可通过该 id 访问这个对象
        WebChannel.id: "backend"

        property string name: "Waleon"

        signal messageSent(string message);

        function randomColor() {
            return Qt.rgba(Math.random(), Math.random(), Math.random(), 1);
        }
    }

    WebChannel {
        id: channel
        // 将对象发布到 Web 端
        registeredObjects: [object]
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        GroupBox {
            Layout.fillHeight: true
            Layout.fillWidth: true
            title: "QML"

            RowLayout {
                spacing: 10

                TextField {
                    id: textField
                }

                Button {
                    text: "Send"
                    // 发射信号，Web 端将接收
                    onClicked: object.messageSent(textField.text)
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }

        GroupBox {
            Layout.fillHeight: true
            Layout.fillWidth: true
            title: "Web"

            WebEngineView {
                anchors.fill: parent
                url: "qrc:/index.html"
                webChannel: channel
            }
        }
    }
}
