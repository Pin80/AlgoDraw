import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles  1.4
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.0
import QtQuick.Window 2.12
import Qt.labs.platform 1.1
import QtQml 2.12
import QtQuick.Shapes 1.12
import ArcDraw 1.0

RowLayout {
    property var  pointslist: []
    signal modelUpdate(int _idx);
    property alias x1text: field_x1.text
    property alias y1text: field_y1.text
    property alias x2text: field_x2.text
    property alias y2text: field_y2.text
    property alias x3text: field_x3.text
    property alias y3text: field_y3.text
    Layout.alignment: Qt.AlignTop
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.preferredHeight: 40
    Layout.maximumHeight: 40
    Label {
        text: "x1"
        Layout.alignment: Qt.AlignTop
        Layout.fillHeight: true
        Layout.preferredHeight: 40
        Layout.maximumWidth: 40
        Layout.minimumWidth: 40
        color: "white"
        activeFocusOnTab: false
        background: Rectangle {
            color: "black"
        }
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    TEdit {
        id: field_x1
        Layout.alignment: Qt.AlignTop
        Layout.fillHeight: true
        Layout.preferredHeight: 40
        Layout.maximumWidth: 40
        Layout.minimumWidth: 40
        Keys.onReturnPressed: {
            modelUpdate(0);
        }
    }
    Label {
        text: "y1"
        Layout.alignment: Qt.AlignTop
        Layout.fillHeight: true
        Layout.preferredHeight: 40
        Layout.maximumWidth: 40
        Layout.minimumWidth: 40
        color: "white"
        activeFocusOnTab: false
        background: Rectangle {
            color: "black"
        }
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    TEdit {
        id: field_y1
        Layout.alignment: Qt.AlignTop
        Layout.fillHeight: true
        Layout.preferredHeight: 40
        Layout.maximumWidth: 40
        Layout.minimumWidth: 40
        Keys.onReturnPressed: {
            modelUpdate(0);
        }
    }
    Label {
        text: "x2"
        Layout.alignment: Qt.AlignTop
        Layout.fillHeight: true
        Layout.preferredHeight: 40
        Layout.maximumWidth: 40
        Layout.minimumWidth: 40
        color: "white"
        activeFocusOnTab: false
        background: Rectangle {
            color: "black"
        }
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    TEdit {
        id: field_x2
        Layout.alignment: Qt.AlignTop
        Layout.fillHeight: true
        Layout.preferredHeight: 40
        Layout.maximumWidth: 40
        Layout.minimumWidth: 40
        Keys.onReturnPressed: {
            modelUpdate(1);
        }
    }
    Label {
        text: "y2"
        Layout.alignment: Qt.AlignTop
        Layout.fillHeight: true
        Layout.preferredHeight: 40
        Layout.maximumWidth: 40
        Layout.minimumWidth: 40
        color: "white"
        activeFocusOnTab: false
        background: Rectangle {
            color: "black"
        }
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    TEdit {
        id: field_y2
        text: "0"
        Layout.alignment: Qt.AlignTop
        Layout.fillHeight: true
        Layout.preferredHeight: 40
        Layout.maximumWidth: 40
        Layout.minimumWidth: 40
        Keys.onReturnPressed: {
            modelUpdate(1);
        }
    }
    Label {
        text: "x3"
        Layout.alignment: Qt.AlignTop
        Layout.fillHeight: true
        Layout.preferredHeight: 40
        Layout.maximumWidth: 40
        Layout.minimumWidth: 40
        color: "white"
        activeFocusOnTab: false
        background: Rectangle {
            color: "black"
        }
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    TEdit {
        id: field_x3
        text: "0"
        Layout.alignment: Qt.AlignTop
        Layout.fillHeight: true
        Layout.preferredHeight: 40
        Layout.maximumWidth: 40
        Layout.minimumWidth: 40
        Keys.onReturnPressed: {
            modelUpdate(2);
        }
    }
    Label {
        text: "y3"
        Layout.alignment: Qt.AlignTop
        Layout.fillHeight: true
        Layout.preferredHeight: 40
        Layout.maximumWidth: 40
        Layout.minimumWidth: 40
        color: "white"
        activeFocusOnTab: false
        background: Rectangle {
            color: "black"
        }
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    TEdit {
        id: field_y3
        Layout.alignment: Qt.AlignTop
        Layout.fillHeight: true
        Layout.preferredHeight: 40
        Layout.maximumWidth: 40
        Layout.minimumWidth: 40
        Keys.onReturnPressed: {
            modelUpdate(2);
        }
    }

}
