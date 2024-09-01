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

Page {
    id: page_algo
    property var lmodel : ListModel {  }
    property alias color: field_algo.color
    property bool arcReady: false
    property int calcrad: 20
    signal editUpdate(int _idx);
    Rectangle {
        id: field_algo
        anchors.fill: parent
        color: "yellow"
        focus: true
        activeFocusOnTab: true
        border.width: 2
        border.color: activeFocus ? "blue":"black"
        Repeater {
            model: (page_algo.lmodel.count > 0)?page_algo.lmodel.count-1:0
            Shape {
                anchors.fill: parent
                visible: arcReady
                ShapePath {
                   id: shapep
                   strokeWidth: 4
                   strokeColor: 'red'
                   startX: page_algo.arcReady? page_algo.lmodel.get(index).xcrd: 0;
                   startY: page_algo.arcReady? page_algo.lmodel.get(index).ycrd: 0;
                    PathArc {
                        x: page_algo.arcReady? page_algo.lmodel.get(index+1).xcrd: 10
                        y: page_algo.arcReady? page_algo.lmodel.get(index+1).ycrd: 0;
                        radiusX: page_algo.arcReady? page_algo.calcrad:5;
                        radiusY: page_algo.arcReady? page_algo.calcrad:5;
                    }
                }
            }
        }

        Repeater {
            model: page_algo.lmodel
            delegate: Rectangle {
                id: currDelegate
                x: (page_algo.lmodel.count > 0)?page_algo.lmodel.get(index).xcrd - width/2:0
                y: (page_algo.lmodel.count > 0)?page_algo.lmodel.get(index).ycrd - height/2:0
                width: 20
                height: width
                color: "blue"
                border.width: 2
                visible: true
                Drag.active: dragArea.drag.active
                MouseArea {
                    id: dragArea
                    anchors.fill: parent
                    drag.target: !page_algo.arcReady? parent: undefined
                    propagateComposedEvents: true
                    drag.axis: Drag.XAndYAxis
                    drag.minimumX: 0
                    drag.maximumX: page_algo.width - width
                    drag.minimumY: 0
                    drag.maximumY: page_algo.height - width
                    onReleased: {
                        page_algo.lmodel.setProperty(index, "xcrd", currDelegate.x + width/2 )
                        page_algo.lmodel.setProperty(index, "ycrd", currDelegate.y + height/2 )
                        editUpdate(index);
                    }
                    onMouseXChanged: {
                        page_algo.lmodel.setProperty(index, "xcrd", currDelegate.x + width/2 )
                        page_algo.lmodel.setProperty(index, "ycrd", currDelegate.y + height/2 )
                        editUpdate(index);
                    }
                    onMouseYChanged: {
                        page_algo.lmodel.setProperty(index, "xcrd", currDelegate.x + width/2 )
                        page_algo.lmodel.setProperty(index, "ycrd", currDelegate.y + height/2 )
                        editUpdate(index);
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
                switch (point_idx) {
                    case 0: {
                        if (page_algo.lmodel.count < 1) {
                            page_algo.lmodel.append({"xcrd": mouse.x, "ycrd":  mouse.y})
                            point_idx = (point_idx + 1)%3;
                            editUpdate(0);
                        }
                        break
                    }
                    case 1: {
                        if (page_algo.lmodel.count < 2) {
                            page_algo.lmodel.append({"xcrd": mouse.x, "ycrd":  mouse.y})
                            point_idx = (point_idx + 1)%3;
                            editUpdate(1);
                        }

                        break
                    }
                    case 2: {
                        if (page_algo.lmodel.count < 3) {
                            page_algo.lmodel.append({"xcrd": mouse.x, "ycrd":  mouse.y})
                            point_idx = (point_idx + 1)%3;
                            editUpdate(2);
                        }
                        break
                    }
                }
                title = qsTr("AlgoDraw: ") + point_idx
                mouse.accepted = false
            }
        }
    }
}

