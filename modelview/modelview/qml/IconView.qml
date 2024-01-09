import QtQuick

ListView {
    width: 100; height: 300

    model: ContactModel {}
    delegate: IconDelegate {}
}
