// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: abstractLayerComponent
    x: 0
    y: 0
    width: 800
    height: 40
    color: "#00000000"
    state: "ENZYME_LAYER"
    property int layerId

    Rectangle {
        id: abstractLayerRectangle
        x: 0
        y: 0
        width: 200
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
        id: innerLayerInput
        color: "#00000000"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 200
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        Text {
            id: productDiffusionUnits
            x: 315
            y: 10
            width: 34
            height: 21
            text: qsTr("μm<sup>2</sup> ∙ s<sup>-1</sup>")
            font.pixelSize: 18
        }

        TextInput {
            id: productDiffusionInput
            x: 242
            y: 10
            width: 72
            height: 21
            text: qsTr("0")
            font.pixelSize: 18
            validator: DoubleValidator {
                bottom: 0
            }
            focus: true
        }

        Text {
            id: productDiffusionText
            x: 200
            y: 10
            text: qsTr("D<sub>P</sub> = ")
            font.pixelSize: 18
        }

        Text {
            id: substrateDiffusionUnits
            x: 125
            y: 10
            width: 34
            height: 21
            text: qsTr("μm<sup>2</sup> ∙ s<sup>-1</sup>")
            font.pixelSize: 18
        }

        TextInput {
            id: substrateDiffusionInput
            x: 53
            y: 10
            width: 72
            height: 21
            text: qsTr("0")
            font.pixelSize: 18
            validator: DoubleValidator {
                bottom: 0
            }
            focus: true
        }

        Text {
            id: substrateDiffusionText
            x: 10
            y: 10
            text: qsTr("D<sub>S</sub> = ")
            font.pixelSize: 18
        }

        Text {
            id: layerThicknessUnits
            x: 502
            y: 10
            width: 34
            height: 21
            text: qsTr("μm")
            font.pixelSize: 18
        }

        Text {
            id: layerThicknessText
            x: 391
            y: 10
            text: qsTr("d = ")
            font.pixelSize: 18
        }

        TextInput {
            id: layerThicknessInput
            x: 424
            y: 10
            width: 72
            height: 21
            text: qsTr("0")
            font.pixelSize: 18
            validator: DoubleValidator {
                bottom: 0
            }
            focus: true
        }

        Image {
            id: removeLayerButton
            x: 542
            y: 5
            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter
            source: "../../red_cross.png"

            MouseArea {
                id: removeLayerMouseArea
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
    }

    Rectangle {
        id: bulkSolutionInput
        color: "#00000000"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 200
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        Text {
            id: substrateConcentrationText
            x: 10
            y: 10
            text: qsTr("[S] = ")
            font.pixelSize: 18
        }

        TextInput {
            id: substrateConcentrationInput
            x: 53
            y: 10
            width: 72
            height: 21
            text: qsTr("0")
            font.pixelSize: 18
            validator: DoubleValidator {
                bottom: 0
            }
            focus: true
        }

        Text {
            id: substrateConcentrationUnits
            x: 125
            y: 10
            width: 34
            height: 21
            text: qsTr("mol ∙ l<sup>-1</sup>")
            font.pixelSize: 18
        }

        Text {
            id: productConcentrationText
            x: 200
            y: 10
            text: qsTr("[P] = ")
            font.pixelSize: 18
        }

        TextInput {
            id: productConcentrationInput
            x: 242
            y: 10
            width: 72
            height: 21
            text: qsTr("0")
            font.pixelSize: 18
            validator: DoubleValidator {
                bottom: 0
            }
            focus: true
        }

        Text {
            id: productConcentrationUnits
            x: 315
            y: 10
            width: 34
            height: 21
            text: qsTr("mol ∙ l<sup>-1</sup>")
            font.pixelSize: 18
        }
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
                        target: innerLayerInput
                        visible: true
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
                        target: innerLayerInput
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
                        target: innerLayerInput
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
                        target: innerLayerInput
                        visible: false
            }
            PropertyChanges {
                        target: bulkSolutionInput
                        visible: false
            }
        }
    ]
}
