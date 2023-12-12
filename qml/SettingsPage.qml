import QtCore
import QtQuick

Rectangle {
    id: rect
    width: 300; height: 200

    // 初始化时，读取配置颜色
    color: inner.readSettings()

    QtObject {
        id: inner

        // 获取配置文件的路径
        function getLocation() {
            var location = StandardPaths.writableLocation(StandardPaths.DocumentsLocation);
            return location + "/settings.ini";
        }

        // 读取配置
        function readSettings() {
            return settings.background
        }

        // 保存配置
        function storeSettings() {
            settings.background = rect.color
        }

        // 随机变色
        function changeColor() {
            rect.color = Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0);
        }
    }

    Settings {
        id: settings
        location: inner.getLocation()
        property color background
    }

    // 点击鼠标时，随机变色
    MouseArea {
        anchors.fill: parent
        onClicked: inner.changeColor();
    }

    // 销毁时，保存配置
    Component.onDestruction: inner.storeSettings()
}
