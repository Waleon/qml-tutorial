import QtQuick
import QtWebView
import QtQuick.Layouts
import QtQuick.Controls

ApplicationWindow {
    visible: true
    width: 800
    height: 600

    menuBar: ToolBar {
        id: navigationBar
        RowLayout {
            anchors.fill: parent
            spacing: 10

            // 后退
            Button {
                text: qsTr("Back")
                enabled: webView.canGoBack
                onClicked: webView.goBack()
            }

            // 前进
            Button {
                text: qsTr("Forward")
                enabled: webView.canGoForward
                onClicked: webView.goForward()
            }

            // 停止/刷新
            Button {
                text: webView.loading ? qsTr("Stop"): qsTr("Refresh")
                onClicked: {
                    webView.loading ? webView.stop() : webView.reload()
                }
            }

            TextField {
                id: urlField
                Layout.fillWidth: true
                placeholderText: "Please enter the website name"
                // 仅允许适合 URL 的字符
                inputMethodHints: Qt.ImhUrlCharactersOnly | Qt.ImhPreferLowercase
                text: webView.url
                onAccepted: webView.url = utils.fromUserInput(text)

                ProgressBar {
                    id: control
                    value: webView.loadProgress === 100 ? 0 : webView.loadProgress
                    anchors.centerIn: parent

                    background: Rectangle {
                        implicitHeight: urlField.height - 2
                        implicitWidth: urlField.width
                        color: "transparent"
                        radius: 2
                    }

                    contentItem: Item {
                        anchors.fill: parent

                        Rectangle {
                            width: control.visualPosition * parent.width
                            height: parent.height
                            opacity: 0.5
                            radius: 2
                            color: "#17a81a"
                        }
                    }
                }
            }

            Button {
                text: qsTr("Go")
                onClicked: {
                    webView.url = utils.fromUserInput(urlField.text)
                }
            }
        }
    }

    WebView {
        id: webView
        anchors.fill: parent

        // WebViewLoadRequest 类型包含所请求 URL 的加载状态信息。
        onLoadingChanged: (loadRequest)=> {
            if (loadRequest.errorString)
                console.error(loadRequest.errorString)
        }
    }

    footer: Label {
        text: webView.loadProgress == 100 ? qsTr("Done") : qsTr("Loading: ") + webView.loadProgress + "%"
    }
}


//ApplicationWindow {
//    width: 800
//    height: 600
//    visible: true

//    WebView {
//        id: webView
//        anchors.fill: parent
//        url: "qrc:///qml/index.html"

//        // 加载状态改变
//        onLoadingChanged: (loadRequest)=> {
//            switch (loadRequest.status )  {
//            case WebView.LoadStartedStatus:
//                console.info("load started: " + loadRequest.url);
//                break;
//            case WebView.LoadSucceededStatus:
//                console.info("load succeeded: " + loadRequest.url);
//                runJS();
//                break;
//            case WebView.LoadFailedStatus:
//                console.error("load failed: " + loadRequest.url + ", error: " + loadRequest.errorString);
//                break;
//            default:
//                break;
//            }
//        }


//        function runJS() {
//            // 1. 获取网页内容
//            // 获取页面的标题
//            webView.runJavaScript("document.title", function(result) {
//                console.info("title: " + result);
//            });

//            // 获取页面的 HTML 内容
//            webView.runJavaScript("document.body.innerHTML", function(result) {
//                console.info("body: " + result);
//            });

//            // 获取指定元素的内容
//            webView.runJavaScript("document.getElementById('myHeader').innerHTML", function(result) {
//                console.info("header: " + result);
//            });

//            // 2. 执行页面操作
//            // 修改元素样式
//            webView.runJavaScript("document.body.style.backgroundColor='gray'")

//            // 设置元素属性
//            webView.runJavaScript("document.getElementById('myHeader').setAttribute('class', 'active')")

//            // 调用 JS 方法
//            var color = "orange";
//            webView.runJavaScript("window.changeColor('" + color + "')")

////            // 3. 与原生代码交互
// //          webView.runJavaScript("nativeFunc()")
//        }
//    }

//    function nativeFunc() {
//        console.info("native func")
//    }
//}
