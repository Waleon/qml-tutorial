//import QtQuick 2.0
//import QtQuick.Controls 2.0
//import QtQuick.Layouts 1.11

//Item {
//    id: root

//    // GET - 同步请求
//    function sendGetRequest() {
//        let xhr = new XMLHttpRequest();
//        xhr.open("GET", "https://httpbin.org/get", false);
//        xhr.responseType = "text"
//        xhr.send();

//        if (xhr.status === 200) {
//            onRequestSuccess(xhr.response);
//        } else {
//            onRequestError(xhr.statusText);
//        }
//    }

//    // GET - 异步请求
//    function sendGetRequestAsync() {
//        let xhr = new XMLHttpRequest()

//        xhr.onreadystatechange = function() {
//            console.info("ready state:" + xhr.readyState);

//            if (xhr.readyState === XMLHttpRequest.DONE) {
//                if (xhr.status === 200) {
//                    onRequestSuccess(xhr.responseText);
//                } else {
//                    onRequestError(xhr.statusText);
//                }
//            }
//        }

//        xhr.open("GET", "https://httpbin.org/get")
//        xhr.send()
//    }

//    // POST - 异步请求
//    function sendPostRequestAsync() {
//        let xhr = new XMLHttpRequest()

//        xhr.onreadystatechange = function() {
//            console.info("ready state:" + xhr.readyState);

//             if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
//                 // 获取所有的响应头
//                 let headers = xhr.getAllResponseHeaders()

//                 // 获取指定的响应头
//                 let header = xhr.getResponseHeader("content-type")

//                 console.info("headers:" + headers);
//                 console.info("header:" + header);

//                 // 解析所有的响应头
//                 let splitHeaders = headers.split("\r\n")
//                 for (var i = 0 ; i < splitHeaders.length ; i++) {
//                     let result = splitHeaders[i].split(": ");
//                     console.info("name:" + result[0]);
//                     console.info("value:" + result[1]);
//                 }
//             }  else if (xhr.readyState === XMLHttpRequest.DONE) {
//                if (xhr.status === 200) {

//                    onRequestSuccess(xhr.responseText);
//                } else {
//                    onRequestError(xhr.statusText);
//                }
//            }
//        }

//        // 设置表单内容（一个或多个字段）
//        var formData = "username=" + "waleon" + "&password=" + "123456"

//        // 发送请求
//        xhr.open("POST", "https://httpbin.org/post")
//        xhr.setRequestHeader('User-Agent', '123')
//        xhr.setRequestHeader('Host', '456')

//        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
//        xhr.send(formData);

//        //        let account = {
//        //            name: "waleon",
//        //            password: "123456"
//        //        }

//        //        let json = JSON.stringify(account)

//        //        xhr.open("POST", "https://httpbin.org/post")
//        //        xhr.setRequestHeader("Content-Type", "application/json; charset=utf-8");
//        //        xhr.send(json)
//    }

//    // 读本地文件
//    function readFile(file) {
//        let xhr = new XMLHttpRequest()

//        xhr.onreadystatechange = function() {
//            if (xhr.readyState === XMLHttpRequest.DONE) {
//                if (xhr.status === 200) {
//                    onRequestSuccess(xhr.responseText);
//                } else {
//                    onRequestError(xhr.statusText);
//                }
//            }
//        }

//        xhr.open("GET", file);
//        xhr.send();
//    }

//    function uploadFile(file) {
//        let xhr = new XMLHttpRequest();

//        xhr.onreadystatechange = function() {
//            if (xhr.readyState === XMLHttpRequest.DONE) {
//                if (xhr.status === 200) {
//                    onRequestSuccess(xhr.responseText);
//                } else {
//                    onRequestError(xhr.statusText);
//                }
//            }
//        }

//        xhr.open("POST", "https://httpbin.org/upload");
//        xhr.setRequestHeader("Content-Type", "multipart/form-data; charset=utf-8");
//        xhr.send(file);
//    }

//    // 消息头
//    function sendHeadersAsync() {
//        let xhr = new XMLHttpRequest()

//        xhr.onreadystatechange = function() {
//             if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
//                 // 获取所有的响应头
//                 let headers = xhr.getAllResponseHeaders()

//                 // 获取指定的响应头
//                 let header = xhr.getResponseHeader("content-type")

//                 console.info("headers:" + headers);
//                 console.info("header:" + header);

//                 // 解析所有的响应头
//                 let splitHeaders = headers.split("\r\n")
//                 for (var i = 0 ; i < splitHeaders.length ; i++) {
//                     let result = splitHeaders[i].split(": ");
//                     console.info("name:" + result[0]);
//                     console.info("value:" + result[1]);
//                 }
//             }
//        }

//        // 设置表单内容（一个或多个字段）
//        var formData = "username=" + "waleon" + "&password=" + "123456"

//        xhr.open("POST", "https://httpbin.org/post")

//        // 使用自定义头信息
//        xhr.setRequestHeader("X-Auth-Token", "xxxxxxxxxxxxxxxx")
//        xhr.setRequestHeader("X-App-Version", "1.0")

//        // 使用标准头信息
//        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");

//        xhr.send(formData);
//    }


//    // 请求成功
//    function onRequestSuccess(response) {
//        console.info("request successful:" + response);
//    }

//    // 请求失败
//    function onRequestError(error) {
//        console.error("request failed:" + error);
//    }

//    RowLayout {
//        anchors.fill: parent
//        anchors.margins: 10
//        spacing: 10

//        Item {
//            Layout.fillWidth: true
//        }

//        Button {
//            text: "Get"
//            onClicked: sendGetRequest()
//        }

//        Button {
//            text: "Get Async"
//            onClicked: sendGetRequestAsync()
//        }

//        Button {
//            text: "Post Async"
//            onClicked: sendPostRequestAsync()
//        }

//        Button {
//            text: "Read File"
//            onClicked: readFile("file:///home/waleon/Desktop/test.txt")
//        }

//        Button {
//            text: "Upload File"
//            onClicked: uploadFile("file:///home/waleon/Desktop/test.txt")
//        }

//        Item {
//            Layout.fillWidth: true
//        }
//    }
//}







import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "qrc:/js/httprequest.js" as XHR

Item {
    width: 800
    height: 600

    property var xhr: null

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        RowLayout {
            anchors.margins: 10
            spacing: 10

            // 请求的 URL 输出框
            TextField {
                id: urlField
                placeholderText: qsTr("http:// or https://")
                text: "http://httpbin.org/get"
            }

            // 发送请求
            Button {
                Layout.alignment: Qt.AlignCenter
                text: "Send"
                onClicked: {
                    textArea.clear()
                    inner.sendRequestAsync(urlField.text)
                }
            }

            // 发送请求
            Button {
                Layout.alignment: Qt.AlignCenter
                text: "Abort"
                onClicked: inner.abort()
            }
        }

        // 显示 HTTP 响应
        TextArea {
            id: textArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            placeholderText: qsTr("HTTP response output")
        }
    }

    QtObject {
        id: inner

        // 发送 HTTP 请求
        function sendRequestAsync(url) {
            xhr = XHR.sendRequestAsync(url, successfulCallback, failedCallback)
        }

        // 请求成功时的回调函数
        function successfulCallback(response) {
            textArea.append("========== headers ==========")
            textArea.append(response.headers)
            textArea.append("========== content ==========")
            textArea.append(response.content)
        }

        // 请求失败时的回调函数
        function failedCallback(error) {
            textArea.append("status:" + error.status)
            textArea.append("statusText:" + error.statusText)
        }

        // 发送 HTTP 请求
        function abort() {
            XHR.abort(xhr)
        }
    }
}
