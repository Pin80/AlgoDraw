import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles  1.4
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.0
import QtQuick.Window 2.12
import Qt.labs.platform 1.1
import QtQml 2.12
import QtQuick.Shapes 1.12
import ArcDraw 1.0
import hullmodel 1.0

Page {
    id: page_algo
    property var lmodel: ListModel {  }
    property var hmodel
    property alias color: field_algo.color
    property bool cvxReady: false
    signal editUpdate(int _idx);
    property bool dragpoint: true
    Rectangle {
        id: field_algo
        anchors.fill: parent
        color: "white"
        activeFocusOnTab: true
        border.width: 2
        border.color: activeFocus ? "blue":"black"
        focus: true
        Shape {
            //anchors.fill: parent
            visible: cvxReady
            ShapePath {
                id: shapePath

                fillColor: "white"
                strokeColor: "red"
                capStyle: ShapePath.RoundCap
                joinStyle: ShapePath.RoundJoin
                strokeWidth: 3
                strokeStyle: ShapePath.SolidLine
                startX: page_algo.cvxReady? page_algo.hmodel.get(0).x: 0;
                startY: page_algo.cvxReady? page_algo.hmodel.get(0).y: 0;
            }
            MouseArea {
                anchors.fill: parent
                propagateComposedEvents: true
                hoverEnabled: true
                onEntered: {
                    shapePath.fillColor = "yellow"
                }
                onExited: {
                    shapePath.fillColor = "white"
                }
            }
        }
        Instantiator {
            model: page_algo.hmodel
            onObjectAdded: shapePath.pathElements.push(object)
            PathLine {
                x: mcoord.x
                y: mcoord.y
            }
        }

        Repeater {
            model:  hmodel
            delegate: Rectangle {
                    width: radius*2
                    height: radius*2
                    visible: true
                    color: mcolor
                    radius: 25
                    x:mcoord.x - radius
                    y:mcoord.y - radius
             }
        }

        Repeater {
            model: page_algo.lmodel
            delegate: Rectangle {
                id: currDelegate
                x: (page_algo.lmodel.count > 0)?page_algo.lmodel.get(index).xcrd - width/2:0
                y: (page_algo.lmodel.count > 0)?page_algo.lmodel.get(index).ycrd - height/2:0
                width: 15
                height: width
                color: "blue"
                border.width: 2
                visible: true
                Drag.active: dragArea.drag.active
                activeFocusOnTab: true
                border.color: currDelegate.activeFocus ? "yellow":"black"
                MouseArea {
                    id: dragArea
                    anchors.fill: parent
                    drag.target: !page_algo.cvxReady? parent: undefined
                    propagateComposedEvents: false
                    drag.axis: Drag.XAndYAxis
                    drag.minimumX: 0
                    drag.maximumX: page_algo.width - width
                    drag.minimumY: 0
                    drag.maximumY: page_algo.height - width
                    onReleased: {
                        page_algo.lmodel.setProperty(index, "xcrd", currDelegate.x + width/2 )
                        page_algo.lmodel.setProperty(index, "ycrd", currDelegate.y + height/2 )
                    }
                    onMouseXChanged: {
                        page_algo.lmodel.setProperty(index, "xcrd", currDelegate.x + width/2 )
                        page_algo.lmodel.setProperty(index, "ycrd", currDelegate.y + height/2 )
                    }
                    onMouseYChanged: {
                        page_algo.lmodel.setProperty(index, "xcrd", currDelegate.x + width/2 )
                        page_algo.lmodel.setProperty(index, "ycrd", currDelegate.y + height/2 )
                    }
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true
            onPressed: {
                var currpt;
                var currrect;
                if (! dragpoint) {
                    if (page_algo.lmodel.count < 10) {
                        field_algo.forceActiveFocus();
                        page_algo.lmodel.append({"xcrd": mouse.x, "ycrd":  mouse.y})
                        point_idx = (point_idx + 1);
                    }
                }
                title = qsTr("AlgoDraw: ") + point_idx
                mouse.accepted = false
            }
        }
        Keys.onPressed: (event)=>
        {
            if (event.modifiers === Qt.ShiftModifier) {
                console.log("shift on")
                dragpoint = false
            }
            else {
                console.log("shift off")
                dragpoint = true
            }
        }
        Keys.onReleased: (event)=>
        {
            if (event.modifiers === Qt.ShiftModifier) {
                dragpoint = false
            }
            else {
                dragpoint = true
            }
        }

    }
}

