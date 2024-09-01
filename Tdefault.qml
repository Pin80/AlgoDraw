import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles  1.4
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.0
import QtQuick.Window 2.12

Page {
    width: 600
    height: 400

    title: qsTr("Home")
    Label {
        text: qsTr("Init page.")
        anchors.centerIn: parent
    }
}
