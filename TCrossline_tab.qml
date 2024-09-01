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
    property var lmodel: ListModel {     }
    property alias color: field_algo.color
    property bool iscrossed: false
    property point crosspoint: Qt.point(30, 30)
    property bool dragpoint: true
    signal editUpdate(int _idx);
    Rectangle {
        id: field_algo
        anchors.fill: parent
        color: "white"
        activeFocusOnTab: true
        border.width: 2
        border.color: activeFocus ? "blue":"black"
        focus: true
        Repeater {
            model: page_algo.lmodel.count
            delegate: Component {
                id: linecomp
                Shape {
                    ShapePath {
                        fillColor: "white"
                        strokeColor: iscrossed?"red":"yellow"
                        capStyle: ShapePath.RoundCap
                        joinStyle: ShapePath.RoundJoin
                        strokeWidth: 3
                        strokeStyle: ShapePath.SolidLine
                        startX: page_algo.lmodel.get(index).xcrd1
                        startY: page_algo.lmodel.get(index).ycrd1
                        PathLine {
                            id: lineend
                            x: page_algo.lmodel.get(index).xcrd2
                            y: page_algo.lmodel.get(index).ycrd2
                        }
                    }
                }
            }
        }

        Repeater {
            model: page_algo.lmodel
            delegate: Rectangle {
                id: currDelegate1
                x: (page_algo.lmodel.count > 0)?page_algo.lmodel.get(index).xcrd1 - width/2:0
                y: (page_algo.lmodel.count > 0)?page_algo.lmodel.get(index).ycrd1 - height/2:0
                width: 15
                height: width
                color: "blue"
                border.width: 2
                visible: true
                Drag.active: darea1.drag.active
                activeFocusOnTab: true
                border.color: currDelegate1.activeFocus ? "yellow":"black"
                MouseArea {
                    id: darea1
                    anchors.fill: parent
                    drag.target: !page_algo.cvxReady? parent: undefined
                    propagateComposedEvents: false
                    drag.axis: Drag.XAndYAxis
                    drag.minimumX: 0
                    drag.maximumX: page_algo.width - width
                    drag.minimumY: 0
                    drag.maximumY: page_algo.height - width
                    onReleased: {
                        page_algo.lmodel.setProperty(index, "xcrd1", currDelegate1.x + width/2 )
                        page_algo.lmodel.setProperty(index, "ycrd1", currDelegate1.y + height/2 )
                    }
                    onMouseXChanged: {
                        page_algo.lmodel.setProperty(index, "xcrd1", currDelegate1.x + width/2 )
                        page_algo.lmodel.setProperty(index, "ycrd1", currDelegate1.y + height/2 )
                    }
                    onMouseYChanged: {
                        page_algo.lmodel.setProperty(index, "xcrd1", currDelegate1.x + width/2 )
                        page_algo.lmodel.setProperty(index, "ycrd1", currDelegate1.y + height/2 )
                    }
                }
            }
        }
        Repeater {
            model: page_algo.lmodel
            delegate: Rectangle {
                id: currDelegate2
                x: (page_algo.lmodel.count > 0)?page_algo.lmodel.get(index).xcrd2 - width/2:0
                y: (page_algo.lmodel.count > 0)?page_algo.lmodel.get(index).ycrd2 - height/2:0
                width: 15
                height: width
                color: "blue"
                border.width: 2
                visible: true
                Drag.active: darea2.drag.active
                activeFocusOnTab: true
                border.color: currDelegate2.activeFocus ? "yellow":"black"
                MouseArea {
                    id: darea2
                    anchors.fill: parent
                    drag.target: !page_algo.cvxReady? parent: undefined
                    propagateComposedEvents: false
                    drag.axis: Drag.XAndYAxis
                    drag.minimumX: 0
                    drag.maximumX: page_algo.width - width
                    drag.minimumY: 0
                    drag.maximumY: page_algo.height - width
                    onReleased: {
                        page_algo.lmodel.setProperty(index, "xcrd2", currDelegate2.x + width/2 )
                        page_algo.lmodel.setProperty(index, "ycrd2", currDelegate2.y + height/2 )
                    }
                    onMouseXChanged: {
                        page_algo.lmodel.setProperty(index, "xcrd2", currDelegate2.x + width/2 )
                        page_algo.lmodel.setProperty(index, "ycrd2", currDelegate2.y + height/2 )
                    }
                    onMouseYChanged: {
                        page_algo.lmodel.setProperty(index, "xcrd2", currDelegate2.x + width/2 )
                        page_algo.lmodel.setProperty(index, "ycrd2", currDelegate2.y + height/2 )
                    }
                }
            }
        }
        Repeater {
            model: page_algo.lmodel
        }
        Rectangle {
                id: crossrect
                x:  iscrossed?crosspoint.x - width/2:0
                y:  iscrossed?crosspoint.y - height/2:0
                width: 15
                height: width
                color: "red"
                border.width: 2
                visible: iscrossed
                border.color: "black"
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
                        var kx =  (mouse.x > field_algo.width/2)?-1:1
                        var ky =  (mouse.y > field_algo.height/2)?-1:1
                        page_algo.lmodel.append(
                                    {
                                        "xcrd1": mouse.x,
                                        "ycrd1":  mouse.y,
                                        "xcrd2": mouse.x + kx*25,
                                        "ycrd2":  mouse.y + ky*25
                                    })
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

