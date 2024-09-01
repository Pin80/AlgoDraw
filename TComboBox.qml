import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles  1.4
import QtQuick.Layouts 1.0
import QtQuick.Window 2.12

ComboBox {
    id: control
    displayText: control.model.text
    activeFocusOnTab: true
    model: ListModel {
        id: controlmodel
        ListElement { text:qsTr("-"); theColor: "yellow" }
    }
    delegate: ItemDelegate {
        id: controldeleg
        hoverEnabled: true
        highlighted: cbox.highlightedIndex === index
        width: control.width
        contentItem:  Rectangle {
            anchors.fill: parent
            color: controldeleg.highlighted?"lightyellow":theColor
            RowLayout {
                spacing: 10
                anchors.fill: parent
                Label {
                    Layout.fillWidth: true;
                    text: model.text ;
                    font.pointSize: 12
                }
            }
        }
    }
    contentItem: Text {
            anchors.fill: parent
            leftPadding: 0
            rightPadding: control.indicator.width + control.spacing
            text: control.model.get(control.currentIndex).text
            font: control.font
            color: "black"
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
    }
    background: Rectangle {
        anchors.fill: parent
        border.color: control.visualFocus ? "blue" : "#21be2b"
        border.width: control.visualFocus ? 2 : 1
        color: control.model.get(control.currentIndex).theColor
        radius: 2
    }
}
