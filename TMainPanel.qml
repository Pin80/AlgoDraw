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
    signal calcAlgo();
    signal clearAlgo();
    signal setPage(int _idx);
    Layout.alignment: Qt.AlignTop
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.preferredHeight: 35
    Layout.maximumHeight: 35
    property alias currpage: cbox.currentIndex
    TButton {
        id: btn_calc
        Layout.alignment: Qt.AlignTop
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.minimumWidth: 20
        buttontext: "Calculate"
        activeFocusOnTab: true
        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true
            onPressed: {
                calcAlgo();
                mouse.accepted = false
            }
        }
    }
    TButton {
        id: btn_clear
        Layout.alignment: Qt.AlignTop
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.minimumWidth: 20
        buttontext: "Clear"
        activeFocusOnTab: true
        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true
            onPressed: {
                clearAlgo();
                mouse.accepted = false
            }
        }
    }
    TComboBox {
        id: cbox
        Layout.fillHeight: true
        Layout.minimumWidth: 200
        Layout.maximumWidth: 200
        displayText: cboxmodel.text
        model: ListModel {
            id: cboxmodel
            ListElement { text:qsTr("Draw Arc"); theColor: "yellow" }
            ListElement { text:qsTr("Draw convex hull");  theColor: "orange" }
            ListElement { text:qsTr("Cross line test"); theColor: "lightgreen"  }
            ListElement { text:qsTr("None"); theColor: "white"  }
        }
        onActivated: {
            setPage(index)
            console.log("current index is:", index)
        }
    }
}
