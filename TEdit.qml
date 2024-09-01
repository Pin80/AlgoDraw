import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles  1.4
import QtQuick.Layouts 1.0
import QtQuick.Window 2.12

TextField {
    id: control
    text: "0"
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    activeFocusOnTab: true
    background: Rectangle {
        anchors.fill: parent
        color: control.activeFocus ? "lightblue":"transparent"
        border.color: control.activeFocus ? "blue" : "transparent"
    }
}
