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
import CrossLine 1.0
import hullmodel 1.0

ApplicationWindow {
    id: wnd
    width: 640
    height: 480
    visible: true
    color: "bisque"
    property int  point_idx: 0
    signal editUpdate(int _idx);
    signal modelUpdate(int _idx);
    property int currAlgo: 0
    ListModel
    {
        id: mainlistmodel
    }

    onEditUpdate: {

    }
    function feditUpdate(_idx) {
        switch (_idx) {
            case 0: {
                ecrdpanel.x1text = mainlistmodel.get(0).xcrd
                ecrdpanel.y1text = mainlistmodel.get(0).ycrd
                break
            }
            case 1: {
                ecrdpanel.x2text = mainlistmodel.get(1).xcrd
                ecrdpanel.y2text = mainlistmodel.get(1).ycrd
                break
            }
            case 2: {
                ecrdpanel.x3text = mainlistmodel.get(2).xcrd
                ecrdpanel.y3text = mainlistmodel.get(2).ycrd
                break
            }
        }
    }

    title: qsTr("AlgoDraw ") + point_idx
    ColumnLayout {
        spacing: 2
        anchors.margins: 2
        anchors.fill: parent
        TMainPanel {
            id: mainpanel
            onCalcAlgo: {
                console.log("lmodel count:",mainlistmodel.count)
                var currpt;
                pointslist = []
                switch (currAlgo) {
                    case 0: {
                        if (mainlistmodel.count < 3)
                            return
                        for (var i1 = 0; i1 < mainlistmodel.count; i1++) {
                            currpt = Qt.point( mainlistmodel.get(i1).xcrd, mainlistmodel.get(i1).ycrd);
                            pointslist.push(currpt)
                        }
                        customArc.setArcPoints(pointslist);
                        console.log("rad:", customArc.r);
                        break;
                    }
                    case 1: {
                        if (mainlistmodel.count < 3)
                            return
                        for (var i1 = 0; i1 < mainlistmodel.count; i1++) {
                            currpt = Qt.point( mainlistmodel.get(i1).xcrd, mainlistmodel.get(i1).ycrd);
                            pointslist.push(currpt)
                        }
                        hullmodel.setCHPoints(pointslist)
                        break;
                    }
                    case 2: {
                        if (mainlistmodel.count < 2)
                            return
                        console.log("algo 3");
                        for (var i1 = 0; i1 < mainlistmodel.count; i1++) {
                            currpt = Qt.point( mainlistmodel.get(i1).xcrd1, mainlistmodel.get(i1).ycrd1);
                            pointslist.push(currpt)
                            currpt = Qt.point( mainlistmodel.get(i1).xcrd2, mainlistmodel.get(i1).ycrd2);
                            pointslist.push(currpt)
                        }
                        crossline.testCrossed(pointslist)
                        break;
                    }
                }
            }
            onClearAlgo: {
                customArc.ptset = false
                mainlistmodel.clear()
                hullmodel.clear();
                crossline.iscrossed = false
                point_idx = 0
            }
            onSetPage: {
                var item
                var item2
                var item3
                currAlgo = _idx
                switch (_idx) {
                    case 0: {
                        clearAlgo()
                        if (stackView.depth == 1) {
                            item = stackView.push("qrc:/Tarc_tab.qml",
                                           { color: "yellow",
                                             arcReady: Qt.binding(function() {
                                                              return customArc.ptset}),
                                             calcrad:  Qt.binding(function() {
                                                              return customArc.r }),
                                             lmodel:   Qt.binding(function() {
                                                                return mainlistmodel
                                                               }) })
                            ecrdpanel.visible = true;
                            item.forceActiveFocus();
                            item.editUpdate.connect(feditUpdate)
                        }
                        else {
                            stackView.currentItem.editUpdate.disconnect(feditUpdate)
                            stackView.pop();
                            item = stackView.push("qrc:/Tarc_tab.qml",
                                           { color: "yellow",
                                             arcReady: Qt.binding(function() {
                                                              return customArc.ptset}),
                                             calcrad:  Qt.binding(function() {
                                                              return customArc.r }),
                                             lmodel:   Qt.binding(function() {
                                                                return mainlistmodel
                                                               }) })
                            ecrdpanel.visible = true;
                            item.forceActiveFocus();
                            item.editUpdate.connect(feditUpdate)
                        }
                        break
                    }
                    case 1: {
                        clearAlgo()
                        if (stackView.depth == 1) {
                            item2 = stackView.push("qrc:/Thull_tab.qml",
                                           { color: "orange",
                                             cvxReady: Qt.binding(function() {
                                                              return hullmodel.ptset}),
                                             lmodel:   Qt.binding(function() {
                                                                return mainlistmodel
                                                               }) ,
                                             hmodel:   Qt.binding(function() {
                                                              return hullmodel
                                                             })
                                                   })
                            ecrdpanel.visible = false;
                            item2.forceActiveFocus();
                            item2.editUpdate.connect(feditUpdate)
                        }
                        else {
                            stackView.currentItem.editUpdate.disconnect(feditUpdate)
                            stackView.pop();
                            item2 = stackView.push("qrc:/Thull_tab.qml",
                                           { color: "orange",
                                             cvxReady: Qt.binding(function() {
                                                              return hullmodel.ptset}),
                                             lmodel:   Qt.binding(function() {
                                                                return mainlistmodel
                                                               }),
                                             hmodel:   Qt.binding(function() {
                                                            return hullmodel
                                                           })
                                                   })
                            ecrdpanel.visible = false;
                            item2.forceActiveFocus();
                            item2.editUpdate.connect(feditUpdate)
                        }
                        break
                    }
                    case 2: {
                        clearAlgo()
                        if (stackView.depth == 1) {
                            item3 = stackView.push("qrc:/TCrossline_tab.qml",
                                           { color: "lightgreen",
                                             iscrossed: Qt.binding(function() {
                                                           return crossline.iscrossed
                                                       }),
                                             crosspoint: Qt.binding(function() {
                                                            return crossline.crosspt
                                             }),
                                             lmodel:   Qt.binding(function() {
                                                                return mainlistmodel
                                                               })
                                                   })
                            ecrdpanel.visible = false;
                            item3.editUpdate.connect(feditUpdate)
                            item3.forceActiveFocus();
                        }
                        else {
                            //stackView.currentItem.editUpdate.disconnect(feditUpdate)
                            stackView.pop();
                            item3 = stackView.push("qrc:/TCrossline_tab.qml",
                                           { color: "lightgreen",
                                             iscrossed: Qt.binding(function() {
                                                         return crossline.iscrossed
                                             }),
                                             crosspoint: Qt.binding(function() {
                                                            return crossline.crosspt
                                             }),
                                             lmodel:   Qt.binding(function() {
                                                                return mainlistmodel
                                                               })
                                            })
                            ecrdpanel.visible = false;
                            item3.forceActiveFocus();
                            item3.editUpdate.connect(feditUpdate)
                        }
                        break
                    }
                    case 3: {
                        if (stackView.depth > 0) {
                            ecrdpanel.visible = false;
                            stackView.currentItem.editUpdate.disconnect(feditUpdate)
                            stackView.pop();
                        }
                        break
                    }
                }
            }
        }

        TEditCrdPanel {
            id: ecrdpanel
            onModelUpdate: {

                switch (_idx) {
                    case 0: {
                        if (mainlistmodel.count > 0) {
                            mainlistmodel.setProperty(0, "xcrd", parseInt(x1text) )
                            mainlistmodel.setProperty(0, "ycrd", parseInt(y1text) )
                        }
                        break
                    }
                    case 1: {
                        if (mainlistmodel.count > 1) {
                            mainlistmodel.setProperty(1, "xcrd", parseInt(x2text) )
                            mainlistmodel.setProperty(1, "ycrd", parseInt(y2text) )
                        }
                        break
                    }
                    case 2: {
                        if (mainlistmodel.count > 2) {
                            mainlistmodel.setProperty(2, "xcrd", parseInt(x3text) )
                            mainlistmodel.setProperty(2, "ycrd", parseInt(y3text) )
                        }
                        break
                    }
                }
            }
        }

        TArcDraw{
            id: customArc
        }
        TConvexHullModel {
            id: hullmodel
        }
        TCrossLine {
            id: crossline
        }

        StackView {
            id: stackView
            initialItem: "qrc:/Tdefault.qml"
            Layout.alignment: Qt.AlignTop
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
    Component.onCompleted: {
        mainpanel.currpage = 0
        mainpanel.setPage(mainpanel.currpage)
    }
}
