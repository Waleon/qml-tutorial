import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtWebSockets

Rectangle {
    width: 500; height: 400

    WebSocketServer {
        id: server

        // 客户端连接列表
        property var clients: []

        // 有新客户端连接建立
        onClientConnected: (webSocket)=> {
            // 将新客户端连接加入列表
            clients.push(webSocket)
            inner.showTip("Client connected")

            // 收到客户端的消息后，进行显示并原封不动的发回去
            webSocket.textMessageReceived.connect(function(message) {
                inner.showReceivedMessage(message)
                webSocket.sendTextMessage(message)
            })

            // 状态发生变化时（例如：断开连接），进行提示
            webSocket.statusChanged.connect(function(status) {
                if (inner != null)
                    inner.showStatusMessage(webSocket, status)
            })
        }

        // 服务器发生错误时触发（例如：端口被占用）
        onErrorStringChanged: inner.showTip("Error: " + errorString)

        // 开启服务
        function start(port) {
            server.port = port
            server.listen = true
        }

        // 停止服务
        function stop() {
            // 断开与所有客户端的连接
            for (let client of server.clients) {
                client.active = false
            }
            // 清空客户端连接列表
            server.clients = []

            // 停止监听
            server.listen = false
        }
    }

    QtObject {
        id: inner

        // 开启服务
        function startService() {
            let port = parseInt(portField.text)
            server.start(port)
            showTip("Server listened")
        }

        // 停止服务
        function stopService() {
            server.stop()
            showTip("Server closed")
        }

        // 显示客户端发送的消息
        function showReceivedMessage(message) {
            let time = Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss")
            let title = "Received message " + time
            let color = "blue"
            title = "<p style='color:%1'> %2 </p>".arg(color).arg(title)
            textArea.append(title)
            textArea.append(message)
        }

        // 显示提示信息
        function showTip(message) {
            textArea.append(message)
        }

        // 根据和客户端的连接状态显示提示信息
        function showStatusMessage(webSocket, status) {
            switch (status) {
            case WebSocket.Closing:
                showTip("Socket closing")
                break
            case WebSocket.Closed:
                showTip("Socket closed")
                break
            case WebSocket.Error:
                showTip("Socket error: " + webSocket.errorString)
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

            // 端口输入框
            TextField {
                id: portField
                text: "8686"
                placeholderText: "port"
            }

            // 监听按钮
            Button {
                text: "Listen"
                onClicked: inner.startService()
            }

            // 关闭按钮
            Button {
                text: "Close"
                onClicked: inner.stopService()
            }
        }

        // 消息显示区域
        TextArea {
            id: textArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            textFormat: TextEdit.RichText
        }
    }
}
