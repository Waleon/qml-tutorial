import QtQuick
import QtQuick.Layouts

Column {
    Repeater {
        model: ContactModel {}
        delegate: DetailDelegate {}
    }
}
