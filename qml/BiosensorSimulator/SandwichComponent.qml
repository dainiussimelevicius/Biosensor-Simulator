// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: abstractLayerComponent
    x: 0
    y: 0
    width: 900
    height: 40
    color: "#00000000"
    state: "ENZYME_LAYER"
    property int layerId

    Rectangle {
        id: abstractLayerRectangle
        x: 0
        y: 0
        width: 120
        height: 40
        color: "#ffffff"
        border.color: "#000000"
        Text {
            id: abstractLayerText
            x: 68
            y: 13
            text: qsTr("Abstract layer")
            font.pixelSize: 12
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: diffusiveLayerInput
        x: 200
        y: 0
        color: "#00000000"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 120
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        Text {
            id: diffProductDiffusionUnits
            x: 297
            y: 9
            width: 64
            height: 21
            text: qsTr("μm<sup>2</sup> ∙ s<sup>-1</sup>")
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }

        Text {
            id: diffProductDiffusionText
            x: 189
            y: 10
            text: qsTr("D<sub>P</sub> = ")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }

        Text {
            id: diffSubstrateDiffusionUnits
            x: 114
            y: 9
            width: 65
            height: 21
            text: qsTr("μm<sup>2</sup> ∙ s<sup>-1</sup>")
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }

        Text {
            id: diffSubstrateDiffusionText
            x: 5
            y: 9
            text: qsTr("D<sub>S</sub> = ")
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }

        Text {
            id: diffLayerThicknessUnits
            x: 475
            y: 9
            width: 26
            height: 21
            text: qsTr("μm")
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }

        Text {
            id: diffLayerThicknessText
            x: 375
            y: 10
            text: qsTr("d = ")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }

        Image {
            id: diffRemoveLayerButton
            x: 509
            y: 5
            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter
            source: "../../red_cross.png"

            MouseArea {
                id: diffRemoveLayerMouseArea
                anchors.fill: parent
                onClicked: {
                    for (var i = 0; i < layersModel.count; i++) {
                        if (layersModel.get(i).layerId == layerId) {
                            layersModel.remove(i);
                            break;
                        }
                    }
                }
            }
        }

        Rectangle {
            id: diffSubstrateDiffusionInputRectangle
            x: 43
            y: 9
            width: 67
            height: 21
            color: "#ffffff"
            radius: 6
            border.width: 4
            border.color: "#008000"

            TextInput {
                id: diffSubstrateDiffusionInput
                text: qsTr("0")
                anchors.rightMargin: 2
                anchors.leftMargin: 2
                anchors.fill: parent
                font.pixelSize: 18
                validator: DoubleValidator {
                    bottom: 0
                }
                focus: true
                Keys.onReleased: {
                    for (var i = 0; i < layersModel.count; i++) {
                        if (layersModel.get(i).layerId == layerId) {
                            layersModel.get(i).Ds = diffSubstrateDiffusionInput.text;
                            break;
                        }
                    }
                    checkTimeStepCurrectness();
                }
            }
        }

        Rectangle {
            id: diffProductDiffusionInputRectangle
            x: 228
            y: 9
            width: 67
            height: 21
            color: "#ffffff"
            radius: 6
            border.width: 4
            border.color: "#008000"

            TextInput {
                id: diffProductDiffusionInput
                text: qsTr("0")
                anchors.rightMargin: 2
                anchors.leftMargin: 2
                anchors.fill: parent
                font.pixelSize: 18
                validator: DoubleValidator {
                    bottom: 0
                }
                focus: true
                Keys.onReleased: {
                    for (var i = 0; i < layersModel.count; i++) {
                        if (layersModel.get(i).layerId == layerId) {
                            layersModel.get(i).Dp = diffProductDiffusionInput.text;
                            break;
                        }
                    }
                    checkTimeStepCurrectness();
                }
            }
        }

        Rectangle {
            id: diffLayerThicknessInputRectangle
            x: 404
            y: 9
            width: 67
            height: 21
            color: "#ffffff"
            radius: 6
            border.width: 4
            border.color: "#008000"

            TextInput {
                id: diffLayerThicknessInput
                text: qsTr("0")
                anchors.rightMargin: 2
                anchors.leftMargin: 2
                anchors.fill: parent
                font.pixelSize: 18
                validator: DoubleValidator {
                    bottom: 0
                }
                focus: true
                Keys.onReleased: {
                    for (var i = 0; i < layersModel.count; i++) {
                        if (layersModel.get(i).layerId == layerId) {
                            layersModel.get(i).d = diffLayerThicknessInput.text;
                            break;
                        }
                    }
                    checkTimeStepCurrectness();
                }
            }
        }
    }

    Rectangle {
        id: bulkSolutionInput
        color: "#00000000"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 120
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        Text {
            id: substrateConcentrationText
            x: 5
            y: 10
            text: qsTr("[S] = ")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }

        Text {
            id: substrateConcentrationUnits
            x: 114
            y: 9
            width: 59
            height: 21
            text: qsTr("mol ∙ l<sup>-1</sup>")
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }

        Text {
            id: productConcentrationText
            x: 189
            y: 10
            text: qsTr("[P] = ")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }

        Text {
            id: productConcentrationUnits
            x: 297
            y: 9
            width: 60
            height: 21
            text: qsTr("mol ∙ l<sup>-1</sup>")
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }

        Rectangle {
            id: substrateConcentrationInputRectangle
            x: 43
            y: 9
            width: 67
            height: 21
            color: "#ffffff"
            radius: 6
            border.width: 4
            border.color: "#008000"

            TextInput {
                id: substrateConcentrationInput
                text: qsTr("0")
                anchors.rightMargin: 2
                anchors.leftMargin: 2
                anchors.fill: parent
                font.pixelSize: 18
                validator: DoubleValidator {
                    bottom: 0
                }
                focus: true
                Keys.onReleased: {
                    for (var i = 0; i < layersModel.count; i++) {
                        if (layersModel.get(i).layerId == layerId) {
                            layersModel.get(i).s0 = substrateConcentrationInput.text;
                            break;
                        }
                    }
                }
            }
        }

        Rectangle {
            id: productConcentrationInputRectangle
            x: 228
            y: 10
            width: 67
            height: 21
            color: "#ffffff"
            radius: 6
            border.width: 4
            border.color: "#008000"

            TextInput {
                id: productConcentrationInput
                text: qsTr("0")
                anchors.rightMargin: 2
                anchors.leftMargin: 2
                anchors.fill: parent
                font.pixelSize: 18
                validator: DoubleValidator {
                    bottom: 0
                }
                focus: true
                Keys.onReleased: {
                    for (var i = 0; i < layersModel.count; i++) {
                        if (layersModel.get(i).layerId == layerId) {
                            layersModel.get(i).p0 = productConcentrationInput.text;
                            break;
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: enzymeLayerInput
        x: 200
        y: 5
        color: "#00000000"
        anchors.top: parent.top
        anchors.topMargin: 0
        Text {
            id: enzProductDiffusionUnits
            x: 297
            y: 9
            width: 65
            height: 21
            text: qsTr("μm<sup>2</sup> ∙ s<sup>-1</sup>")
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }

        Text {
            id: enzProductDiffusionText
            x: 189
            y: 9
            text: qsTr("D<sub>P</sub> = ")
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }

        Text {
            id: enzSubstrateDiffusionUnits
            x: 114
            y: 9
            width: 65
            height: 21
            text: qsTr("μm<sup>2</sup> ∙ s<sup>-1</sup>")
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }

        Text {
            id: enzSubstrateDiffusionText
            x: 5
            y: 10
            text: qsTr("D<sub>S</sub> = ")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }

        Text {
            id: enzLayerThicknessUnits
            x: 475
            y: 9
            width: 34
            height: 21
            text: qsTr("μm")
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }

        Text {
            id: enzLayerThicknessText
            x: 375
            y: 9
            text: qsTr("d = ")
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }

        Image {
            id: enzRemoveLayerButton
            x: 694
            y: 10
            width: 20
            height: 20
            anchors.verticalCenterOffset: 0
            MouseArea {
                id: enzRemoveLayerMouseArea
                anchors.verticalCenter: parent.verticalCenter
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.left: parent.left
                onClicked: {
                    for (var i = 0; i < layersModel.count; i++) {
                        if (layersModel.get(i).layerId == layerId) {
                            layersModel.remove(i);
                            break;
                        }
                    }
                }
            }
            source: "../../red_cross.png"
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: enzEnzymeConcentrationUnits
            x: 626
            y: 9
            width: 60
            height: 21
            text: qsTr("mol ∙ l<sup>-1</sup>")
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }

        Text {
            id: enzEnzymeConcentrationText
            x: 509
            y: 9
            text: qsTr("[E<sub>0</sub>] = ")
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
        }

        Rectangle {
            id: enzEnzymeConcentrationInputRectangle
            x: 556
            y: 9
            width: 67
            height: 21
            color: "#ffffff"
            radius: 6
            border.width: 4
            border.color: "#008000"

            TextInput {
                id: enzEnzymeConcentrationInput
                text: qsTr("0")
                anchors.rightMargin: 2
                anchors.leftMargin: 2
                anchors.fill: parent
                font.pixelSize: 18
                validator: DoubleValidator {
                    bottom: 0
                }
                focus: true
                Keys.onReleased: {
                    for (var i = 0; i < layersModel.count; i++) {
                        if (layersModel.get(i).layerId == layerId) {
                            layersModel.get(i).e0 = enzEnzymeConcentrationInput.text;
                            break;
                        }
                    }
                }
            }
        }

        Rectangle {
            id: enzSubstrateDiffusionInputRectangle
            x: 43
            y: 9
            width: 67
            height: 21
            color: "#ffffff"
            radius: 6
            border.width: 4
            border.color: "#008000"

            TextInput {
                id: enzSubstrateDiffusionInput
                text: qsTr("0")
                anchors.rightMargin: 2
                anchors.leftMargin: 2
                anchors.fill: parent
                font.pixelSize: 18
                validator: DoubleValidator {
                    bottom: 0
                }
                focus: true
                Keys.onReleased: {
                    for (var i = 0; i < layersModel.count; i++) {
                        if (layersModel.get(i).layerId == layerId) {
                            layersModel.get(i).Ds = enzSubstrateDiffusionInput.text;
                            break;
                        }
                    }
                    checkTimeStepCurrectness();
                }
            }
        }

        Rectangle {
            id: enzProductDiffusionInputRectangle
            x: 228
            y: 9
            width: 67
            height: 21
            color: "#ffffff"
            radius: 6
            border.width: 4
            border.color: "#008000"

            TextInput {
                id: enzProductDiffusionInput
                text: qsTr("0")
                anchors.rightMargin: 2
                anchors.leftMargin: 2
                anchors.fill: parent
                font.pixelSize: 18
                validator: DoubleValidator {
                    bottom: 0
                }
                focus: true
                Keys.onReleased: {
                    for (var i = 0; i < layersModel.count; i++) {
                        if (layersModel.get(i).layerId == layerId) {
                            layersModel.get(i).Dp = enzProductDiffusionInput.text;
                            break;
                        }
                    }
                    checkTimeStepCurrectness();
                }
            }
        }

        Rectangle {
            id: enzLayerThicknessInputRectangle
            x: 404
            y: 9
            width: 67
            height: 21
            color: "#ffffff"
            radius: 6
            border.width: 4
            border.color: "#008000"

            TextInput {
                id: enzLayerThicknessInput
                text: qsTr("0")
                anchors.rightMargin: 2
                anchors.leftMargin: 2
                anchors.fill: parent
                font.pixelSize: 18
                validator: DoubleValidator {
                    bottom: 0
                }
                focus: true
                Keys.onReleased: {
                    for (var i = 0; i < layersModel.count; i++) {
                        if (layersModel.get(i).layerId == layerId) {
                            layersModel.get(i).d = enzLayerThicknessInput.text;
                            break;
                        }
                    }
                    checkTimeStepCurrectness();
                }
            }
        }
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.leftMargin: 120
        anchors.left: parent.left
    }
    states: [
        State {
            name: "ENZYME_LAYER"
            PropertyChanges {
                target: abstractLayerText
                text: qsTr("Enzyme layer")
            }
            PropertyChanges {
                target: abstractLayerRectangle
                color: "lightsteelblue"
            }
            PropertyChanges {
                        target: enzymeLayerInput
                        visible: true
            }
            PropertyChanges {
                        target: diffusiveLayerInput
                        visible: false
            }
            PropertyChanges {
                        target: bulkSolutionInput
                        visible: false
            }
        },
        State {
            name: "DIFFUSIVE_LAYER"
            PropertyChanges {
                target: abstractLayerText
                text: qsTr("Diffusive layer")
            }
            PropertyChanges {
                target: abstractLayerRectangle
                color: "darkseagreen"
            }
            PropertyChanges {
                        target: enzymeLayerInput
                        visible: false
            }
            PropertyChanges {
                        target: diffusiveLayerInput
                        visible: true
            }
            PropertyChanges {
                        target: bulkSolutionInput
                        visible: false
            }
        },
        State {
            name: "BULK_SOLUTION"
            PropertyChanges {
                target: abstractLayerText
                text: qsTr("Bulk solution")
            }
            PropertyChanges {
                target: abstractLayerRectangle
                color: "white"
            }
            PropertyChanges {
                        target: enzymeLayerInput
                        visible: false
            }
            PropertyChanges {
                        target: diffusiveLayerInput
                        visible: false
            }
            PropertyChanges {
                        target: bulkSolutionInput
                        visible: true
            }
        },
        State {
            name: "ELECTRODE"
            PropertyChanges {
                target: abstractLayerText
                text: qsTr("Electrode")
            }            
            PropertyChanges {
                target: abstractLayerRectangle
                color: "#625e5e"
            }
            PropertyChanges {
                        target: enzymeLayerInput
                        visible: false
            }
            PropertyChanges {
                        target: diffusiveLayerInput
                        visible: false
            }
            PropertyChanges {
                        target: bulkSolutionInput
                        visible: false
            }
        }
    ]
}
