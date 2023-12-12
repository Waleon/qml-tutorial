import QtQuick
import QtQuick.Controls
import QtWebEngine

ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 600

    WebEngineView {
        id: engineView
        anchors.fill: parent
        url: "qrc:/index.html"

        onFullScreenRequested: function(request) {
            if (request.toggleOn) {
                window.showFullScreen()
            } else {
                window.showNormal()
            }

            // 接受全屏请求（会将 WebEngineView::isFullScreen 设置为 toggleOn 的值）
            request.accept()
        }
    }
}
