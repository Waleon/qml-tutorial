import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "qrc:/js/database.js" as DB

Rectangle {
    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        RowLayout {
            spacing: 10

            TextField {
                id: nameField
                placeholderText: "Name"
            }

            TextField {
                id: phoneField
                placeholderText: "Phone"
            }

            Button {
                text: "Add"
                onClicked: inner.addRow()
            }

            Button {
                text: "Update"
                onClicked: inner.updateRow()
            }

            Button {
                text: "Remove"
                onClicked: inner.removeRow()
            }
        }

        // 通讯录
        ListView {
            id: contactsView
            Layout.fillWidth: true
            Layout.fillHeight: true

            // header
            Component {
                id: headerView
                Item {
                    width: contactsView.width
                    height: 30
                    RowLayout {
                        spacing: 10
                        Text { text: "Name"; font.bold: true; Layout.preferredWidth: 80 }
                        Text { text: "Phone"; font.bold: true; Layout.preferredWidth: 80 }
                    }
                }
            }

            // delegate
            Component {
                id: contactsDelegate
                Rectangle {
                    id: wrapper
                    width: contactsView.width
                    height: 30
                    // 根据是否当前项，控制背景色
                    color: ListView.isCurrentItem ? "lightsteelblue" : "transparent"

                    RowLayout {
                        spacing: 10
                        Text { text: model.name; Layout.preferredWidth: 80 }
                        Text { text: model.phone; Layout.preferredWidth: 80 }
                    }

                    // 鼠标点击时，改变当前项
                    MouseArea {
                        anchors.fill: parent
                        onClicked: wrapper.ListView.view.currentIndex = index
                    }
                }
            }

            model: ListModel { id: contactsModel }
            delegate: contactsDelegate
            header: headerView

            onCurrentIndexChanged: {
                if (currentIndex >= 0) {
                    let obj = model.get(currentIndex)
                    nameField.text = obj.name
                    phoneField.text = obj.phone
                }
            }
        }
    }

    // 加载、添加、更新、删除联系人等操作
    QtObject {
        id: inner

        // 加载数据库中的所有联系人
        function init() {
            DB.initDB()
            var results = DB.readAll()
            results.forEach(function (element, index, array) {
                contactsModel.append({id: element.rowid, name: element.name, phone: element.phone})
            });
        }

        // 获取输入框中的姓名和电话，并将其添加到通讯录中
        function addRow() {
            var rowid = DB.insertRow(nameField.text, phoneField.text)
            if (rowid > 0)
                contactsModel.append({id: rowid, name: nameField.text, phone: phoneField.text})
        }

        // 更新选中的联系人
        function updateRow() {
            var index = contactsView.currentIndex
            if (index >= 0) {
                var id = contactsView.model.get(index).id
                if (DB.updateRow(id, nameField.text, phoneField.text))
                    contactsModel.set(index, {id: id, name: nameField.text, phone: phoneField.text})
            }
        }

        // 删除选中的联系人
        function removeRow() {
            var index = contactsView.currentIndex
            if (index >= 0) {
                var id = contactsView.model.get(index).id
                if (DB.deleteRow(id))
                    contactsModel.remove(index)
            }
        }
    }

    // 初始化数据库，并加载联系人
    Component.onCompleted: inner.init()
}
