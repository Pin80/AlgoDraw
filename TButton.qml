import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles  1.4
import QtQuick.Layouts 1.0
import QtQuick.Window 2.12

Rectangle {
        id: control
        property bool pressed: false
        property bool hovered: false
        color:  pressed ? "green" : (hovered ? "greenyellow": "lawngreen")
        border.color: activeFocus? "blue" :"lightgrey"
        border.width: activeFocus? 1: 3
        radius: 4
        property alias buttontext: textctrl.text
        Text {
            id:textctrl
            anchors.fill: parent
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: control.hovered = true
            onExited: control.hovered = false
            onPressed: control.pressed = true
            onReleased: control.pressed = false
        }
}
