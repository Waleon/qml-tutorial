import QtQuick
import QtWebEngine
import QtQuick.Layouts
import QtQuick.Controls

ApplicationWindow {
    width: 800
    height: 600
    visible: true

    // 工具栏
    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            spacing: 10
            ToolButton {
                text: "Get Content"
                onClicked: inner.getContent()
            }
            ToolButton {
                text: "Change Style"
                onClicked: inner.changeStyle()
            }
            ToolButton {
                text: "Run JS"
                onClicked: inner.runJS()
            }
            Item {
                Layout.fillWidth: true
            }
        }
    }

    // 加载 Web 页面
    WebEngineView {
        id: engineView
        anchors.fill: parent
        url: "qrc:/index.html"
    }

    // JavaScript 调用
    QtObject {
        id: inner

        function getContent() {
            // 获取页面的标题
            engineView.runJavaScript("document.title", function(result) {
                console.info("title: " + result);
            });

            // 获取页面的 HTML 内容
            engineView.runJavaScript("document.body.innerHTML", function(result) {
                console.info("body: " + result);
            });

            // 获取指定元素的内容
            engineView.runJavaScript("document.getElementById('myHeader').innerHTML", function(result) {
                console.info("header: " + result);
            });
        }

        function changeStyle() {
            // 修改元素样式
            engineView.runJavaScript("document.body.style.backgroundColor='gray'")

            // 设置元素属性
            engineView.runJavaScript("document.getElementById('myHeader').setAttribute('class', 'active')")
        }

        function runJS() {
            var color = Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
            engineView.runJavaScript("window.changeColor('" + color + "')")
        }
    }
}
