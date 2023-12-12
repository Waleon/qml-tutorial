import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtWebSockets

Rectangle {
    width: 500; height: 400

    WebSocket {
        id: socket

        // 接受服务端的消息，直接显示
        onTextMessageReceived: (message)=> {
                                   inner.showMessage(message, true)
                               }

        // 状态发生变化时（例如：断开连接），进行提示
        onStatusChanged: (status)=> {
                             inner.showStatusTip(status)
                         }

        // 连接至服务器
        function connectToServer(url) {
            socket.url = url
            socket.active = true
        }

        // 断开与服务器的连接
        function disconnectFromServer() {
            socket.active = false
        }

        // 发送消息至服务器
        function sendTextMessageToServer(message) {
            if (socket.status === WebSocket.Open) {
                socket.sendTextMessage(message)
                return true
            } else {
                return false
            }
        }
    }

    QtObject {
        id: inner

        // 发送消息给服务器（发送后，清空消息输出框，并显示已发送的消息）
        function sendMessage() {
            let message = textField.text
            textField.clear()
            let isSuccess = socket.sendTextMessageToServer(message)
            if (isSuccess) {
                showMessage(message, false)
            } else {
                showTip("socket is not open, please connect first")
            }
        }

        // 显示消息（isReceived：true 表示发送消息，false 表示接收消息）
        function showMessage(message, isReceived) {
            let time = Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss")
            let title = isReceived ? "Received message" : "Sent message"
            let color = isReceived ? "blue" : "green"
            title = title + " " + time
            title = "<p style='color:%1'> %2 </p>".arg(color).arg(title)
            textArea.append(title)
            textArea.append(message)
        }

        // 显示提示信息
        function showTip(message) {
            textArea.append(message)
        }

        // 根据状态显示提示信息
        function showStatusTip(status) {
            switch (status) {
            case WebSocket.Connecting:
                showTip("Socket connecting")
                break
            case WebSocket.Open:
                showTip("Socket opened")
                break
            case WebSocket.Closing:
                showTip("Socket closing")
                break
            case WebSocket.Closed:
                showTip("Socket closed")
                break
            case WebSocket.Error:
                showTip("Socket error: " + socket.errorString)
                break
            default:
                break
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        RowLayout {
            spacing: 10

            // 服务器 URL 输入框
            TextField {
                id: urlField
                text: "wss://ws.postman-echo.com/raw"
                placeholderText: "ws:// or wss://"
            }

            // 连接按钮
            Button {
                text: "Connect"
                onClicked: socket.connectToServer(urlField.text)
            }

            // 断开按钮
            Button {
                text: "Disconnect"
                onClicked: socket.disconnectFromServer()
            }
        }

        // 消息显示区域
        TextArea {
            id: textArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            textFormat: TextEdit.RichText
        }

        RowLayout {
            spacing: 10

            // 消息输入框
            TextField {
                id: textField
                placeholderText: "message"
            }

            // 点击，发送消息
            Button {
                text: "Send"
                onClicked: inner.sendMessage()
            }
        }
    }
}
