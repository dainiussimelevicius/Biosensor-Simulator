// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: page
    width: 1024
    height: 768
    color: "#000000"
    state: "REACTIONS"

    Rectangle {
        id: leftRectangle
        width: 148
        color: "#d3d3d3"
        radius: 0
        anchors.left: parent.left
        anchors.leftMargin: 1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 51
        anchors.top: parent.top
        anchors.topMargin: 1

        Column {
            id: buttonColumn
            anchors.fill: parent

            Rectangle {
                id: leftHeader
                height: 30
                width: 148
                radius: 0
                smooth: true
                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: "#d3d3d3"
                    }

                    GradientStop {
                        position: 1
                        color: "#545454"
                    }
                }
                Text {
                    id: leftHeaderText
                    x: 44
                    y: 15
                    text: qsTr("Configuration")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 12
                }
            }

            Rectangle {
                id: reactionsButton
                width: 148
                height: 30
                color: "#d3d3d3"
                radius: 6
                border.color: "#000000"
                smooth: true
                Text {
                    id: reactionsButtonText
                    x: 44
                    y: 15
                    text: qsTr("Reactions")
                    font.pixelSize: 12
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                MouseArea {
                    id: reactionsButtonMouseArea
                    anchors.fill: parent
                    onClicked: page.state = 'REACTIONS'
                }
            }

            Rectangle {
                id: kineticsButton
                width: 148
                height: 30
                color: "#d3d3d3"
                radius: 6
                border.color: "#000000"
                smooth: true
                Text {
                    id: kineticsButtonText
                    x: 44
                    y: 15
                    text: qsTr("Kinetics")
                    font.pixelSize: 12
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                MouseArea {
                    id: kineticsButtonMouseArea
                    anchors.fill: parent
                    onClicked: page.state = 'KINETICS'
                }
            }

            Rectangle {
                id: geometryButton
                width: 148
                height: 30
                color: "#d3d3d3"
                radius: 6
                border.color: "#000000"
                smooth: true
                Text {
                    id: geometryButtonText
                    x: 44
                    y: 15
                    text: qsTr("Geometry")
                    font.pixelSize: 12
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                MouseArea {
                    id: geometryButtonMouseArea
                    anchors.fill: parent
                    onClicked: page.state = 'GEOMETRY'
                }
            }

            Rectangle {
                id: calculationsButton
                width: 148
                height: 30
                color: "#d3d3d3"
                radius: 6
                border.color: "#000000"
                smooth: true
                Text {
                    id: calculationsButtonText
                    x: 44
                    y: 15
                    text: qsTr("Calculations")
                    font.pixelSize: 12
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                MouseArea {
                    id: calculationsButtonMouseArea
                    anchors.fill: parent
                    onClicked: page.state = 'CALCULATIONS'
                }
            }
        }
    }

    Rectangle {
        id: rightRectangle
        color: "#d3d3d3"
        radius: 0
        anchors.right: parent.right
        anchors.rightMargin: 1
        anchors.left: parent.left
        anchors.leftMargin: 150
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 51
        anchors.top: parent.top
        anchors.topMargin: 1

        Rectangle {
            id: rightHeader
            height: 30
            radius: 0
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#d3d3d3"
                }

                GradientStop {
                    position: 1
                    color: "#545454"
                }
            }
            smooth: true
            anchors.top: parent.top
            anchors.topMargin: 0
            Text {
                id: rightHeaderText
                x: 44
                y: 15
                text: qsTr("Model")
                font.pixelSize: 12
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            anchors.rightMargin: 0
            anchors.right: parent.right
            anchors.leftMargin: 0
            anchors.left: parent.left
        }

        Rectangle {
            id: kineticsRectangle
            width: 649
            height: 518
            color: "#00000000"
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 30

            QtObject {
                id: constantCalculator
                function calculateKm(k1, k_1, k2) {
                    var km = (parseFloat(k_1.replace(",", ".")) + parseFloat(k2.replace(",", "."))) / parseFloat(k1.replace(",", "."));
                    return km.toExponential(4).toString();
                }
                function calculateKInhibition(kf, kb) {
                    var k = parseFloat(kb.replace(",", ".")) / parseFloat(kf.replace(",", "."));
                    return k.toExponential(4).toString();
                }
            }

            Text {
                id: k1ConstantText
                x: 39
                y: 53
                text: qsTr("k<sub>1</sub> = ")
                font.pixelSize: 18
            }

            TextInput {
                id: k1TextInput
                x: 82
                y: 53
                width: 72
                height: 21
                text: qsTr("0")
                font.pixelSize: 18
                validator: DoubleValidator{bottom: 0;}
                focus: true
                onAccepted: {
                    if (!k1TextInput.acceptableInput)
                        k1TextInput.color = "red";
                    else
                        k1TextInput.color = "black";
                    kmConstant.text = constantCalculator.calculateKm(k1TextInput.text, k_1TextInput.text, k2TextInput.text);
                }
            }

            Text {
                id: k1UnitsText
                x: 154
                y: 53
                width: 90
                height: 21
                text: qsTr("mol<sup>-1</sup> ∙ l ∙ s<sup>-1</sup>")
                font.pixelSize: 18
            }

            Text {
                id: k_1ConstantText
                x: 39
                y: 87
                text: qsTr("k<sub>-1</sub> = ")
                font.pixelSize: 18
            }

            TextInput {
                id: k_1TextInput
                x: 82
                y: 87
                width: 72
                height: 21
                text: qsTr("0")
                font.pixelSize: 18
                validator: DoubleValidator{bottom: 0;}
                focus: true
                onAccepted: { kmConstant.text = constantCalculator.calculateKm(k1TextInput.text, k_1TextInput.text, k2TextInput.text); }
            }

            Text {
                id: k_1UnitsText
                x: 154
                y: 87
                width: 34
                height: 21
                text: qsTr("s<sup>-1</sup>")
                font.pixelSize: 18
            }

            Text {
                id: k2ConstantText
                x: 39
                y: 121
                text: qsTr("k<sub>2</sub> = ")
                font.pixelSize: 18
            }

            TextInput {
                id: k2TextInput
                x: 82
                y: 121
                width: 72
                height: 21
                text: qsTr("0")
                font.pixelSize: 18
                validator: DoubleValidator{bottom: 0;}
                focus: true
                onAccepted: { kmConstant.text = constantCalculator.calculateKm(k1TextInput.text, k_1TextInput.text, k2TextInput.text); }
            }

            Text {
                id: k2UnitsText
                x: 154
                y: 121
                width: 34
                height: 21
                text: qsTr("s<sup>-1</sup>")
                font.pixelSize: 18
            }

            Text {
                id: kMConstantText
                x: 305
                y: 87
                text: qsTr("K<sub>M</sub> = ")
                font.pixelSize: 18
            }

            Rectangle {
                id: kmFractionLine
                x: 345
                y: 97
                width: 79
                height: 1
                color: "#000000"
                border.color: "#000000"
            }

            Text {
                id: kMNumeratorText
                x: 356
                y: 77
                text: qsTr("k<sub>-1</sub> + k<sub>2</sub>")
                font.pixelSize: 18
            }

            Text {
                id: kMDenominatorText
                x: 375
                y: 100
                text: qsTr("k<sub>1</sub>")
                font.pixelSize: 18
            }

            Text {
                id: kMEqualText
                x: 424
                y: 87
                text: qsTr(" = ")
                font.pixelSize: 18
            }

            Text {
                id: kMUnitsText
                x: 531
                y: 87
                text: qsTr("mol ∙ l<sup>-1</sup>")
                font.pixelSize: 18
            }

            Text {
                id: kmConstant
                x: 443
                y: 87
                width: 85
                height: 21
                text: qsTr("0")
                font.pixelSize: 18
            }

            Text {
                id: k3ConstantText
                x: 39
                y: 204
                text: qsTr("k<sub>3</sub> = ")
                font.pixelSize: 18
            }

            TextInput {
                id: k3TextInput
                x: 82
                y: 204
                width: 72
                height: 21
                text: qsTr("0")
                font.pixelSize: 18
                validator: DoubleValidator{bottom: 0;}
                focus: true
                onAccepted: { ksConstant.text = constantCalculator.calculateKInhibition(k3TextInput.text, k_3TextInput.text); }
            }

            Text {
                id: k3UnitsText
                x: 154
                y: 204
                width: 90
                height: 21
                text: qsTr("mol<sup>-1</sup> ∙ l ∙ s<sup>-1</sup>")
                font.pixelSize: 18
            }

            Text {
                id: k_3ConstantText
                x: 39
                y: 238
                text: qsTr("k<sub>-3</sub> = ")
                font.pixelSize: 18
            }

            TextInput {
                id: k_3TextInput
                x: 82
                y: 238
                width: 72
                height: 21
                text: qsTr("0")
                font.pixelSize: 18
                validator: DoubleValidator{bottom: 0;}
                focus: true
                onAccepted: { ksConstant.text = constantCalculator.calculateKInhibition(k3TextInput.text, k_3TextInput.text); }
            }

            Text {
                id: k_3UnitsText
                x: 154
                y: 238
                width: 34
                height: 21
                text: qsTr("s<sup>-1</sup>")
                font.pixelSize: 18
            }

            Text {
                id: kSConstantText
                x: 305
                y: 222
                text: qsTr("K<sub>s</sub> = ")
                font.pixelSize: 18
            }

            Rectangle {
                id: ksFractionLine
                x: 345
                y: 232
                width: 40
                height: 1
                color: "#000000"
                border.color: "#000000"
            }

            Text {
                id: kSNumeratorText
                x: 356
                y: 212
                text: qsTr("k<sub>-3</sub>")
                font.pixelSize: 18
            }

            Text {
                id: kSDenominatorText
                x: 356
                y: 233
                text: qsTr("k<sub>3</sub>")
                font.pixelSize: 18
            }

            Text {
                id: kSEqualText
                x: 391
                y: 222
                text: qsTr(" = ")
                font.pixelSize: 18
            }

            Text {
                id: kSUnitsText
                x: 499
                y: 222
                text: qsTr("mol ∙ l<sup>-1</sup>")
                font.pixelSize: 18
            }

            Text {
                id: ksConstant
                x: 410
                y: 222
                width: 85
                height: 21
                text: qsTr("0")
                font.pixelSize: 18
            }

            Text {
                id: k4ConstantText
                x: 39
                y: 316
                text: qsTr("k<sub>4</sub> = ")
                font.pixelSize: 18
            }

            TextInput {
                id: k4TextInput
                x: 82
                y: 316
                width: 72
                height: 21
                text: qsTr("0")
                font.pixelSize: 18
                validator: DoubleValidator{bottom: 0;}
                focus: true
                onAccepted: { kpConstant.text = constantCalculator.calculateKInhibition(k4TextInput.text, k_4TextInput.text); }
            }

            Text {
                id: k4UnitsText
                x: 154
                y: 316
                width: 90
                height: 21
                text: qsTr("mol<sup>-1</sup> ∙ l ∙ s<sup>-1</sup>")
                font.pixelSize: 18
            }

            Text {
                id: k_4ConstantText
                x: 39
                y: 350
                text: qsTr("k<sub>-4</sub> = ")
                font.pixelSize: 18
            }

            TextInput {
                id: k_4TextInput
                x: 82
                y: 350
                width: 72
                height: 21
                text: qsTr("0")
                font.pixelSize: 18
                validator: DoubleValidator{bottom: 0;}
                focus: true
                onAccepted: { kpConstant.text = constantCalculator.calculateKInhibition(k4TextInput.text, k_4TextInput.text); }
            }

            Text {
                id: k_4UnitsText
                x: 154
                y: 350
                width: 34
                height: 21
                text: qsTr("s<sup>-1</sup>")
                font.pixelSize: 18
            }

            Text {
                id: kPConstantText
                x: 305
                y: 334
                text: qsTr("K<sub>p</sub> = ")
                font.pixelSize: 18
            }

            Rectangle {
                id: kpFractionLine
                x: 345
                y: 344
                width: 40
                height: 1
                color: "#000000"
                border.color: "#000000"
            }

            Text {
                id: kPNumeratorText
                x: 356
                y: 324
                text: qsTr("k<sub>-4</sub>")
                font.pixelSize: 18
            }

            Text {
                id: kPDenominatorText
                x: 356
                y: 345
                text: qsTr("k<sub>4</sub>")
                font.pixelSize: 18
            }

            Text {
                id: kPEqualText
                x: 391
                y: 334
                text: qsTr(" = ")
                font.pixelSize: 18
            }

            Text {
                id: kPUnitsText
                x: 499
                y: 334
                text: qsTr("mol ∙ l<sup>-1</sup>")
                font.pixelSize: 18
            }

            Text {
                id: kpConstant
                x: 410
                y: 334
                width: 85
                height: 21
                text: qsTr("0")
                font.pixelSize: 18
            }

            Text {
                id: mainConstantsText
                x: 39
                y: 15
                text: qsTr("Reaction rate constants of Michaelis-Menten equation")
                font.pixelSize: 20
            }

            Text {
                id: substrateConstantsText
                x: 39
                y: 163
                text: qsTr("Reaction rate constants of substrate inhibition equations")
                font.pixelSize: 20
            }

            Text {
                id: productConstantsText
                x: 39
                y: 277
                text: qsTr("Reaction rate constants of product inhibition equations")
                font.pixelSize: 20
            }
        }

        Rectangle {
            id: reactionRectangle
            width: 649
            color: "#00000000"
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 30

            Text {
                id: k1Const
                x: 135
                y: 61
                text: qsTr("k<sub>1</sub>")
                font.pixelSize: 18
            }

            Text {
                id: mainReaction
                x: 45
                y: 77
                text: qsTr("E + S   ⇄   ES   →   E + P")
                font.pixelSize: 30
            }

            Text {
                id: substrateInhibitionReaction
                x: 45
                y: 206
                text: qsTr("ES + S   ⇄   ESS")
                font.pixelSize: 30
            }

            Text {
                id: productInhibitionReaction
                x: 45
                y: 337
                text: qsTr("E + P   ⇄   EP")
                font.pixelSize: 30
            }

            Text {
                id: mainEquationText
                x: 45
                y: 15
                text: qsTr("Michaelis-Menten equation")
                font.pixelSize: 20
            }

            Text {
                id: substrateInhibitionText
                x: 45
                y: 155
                text: qsTr("Equation of substrate inhibition")
                font.pixelSize: 20
            }

            Text {
                id: productInhibitionText
                x: 45
                y: 285
                text: qsTr("Equation of product inhibition")
                font.pixelSize: 20
            }

            Text {
                id: legendSubstrateText
                x: 45
                y: 551
                text: qsTr("S - substrate")
                font.pixelSize: 16
            }

            Text {
                id: legendEnzymeText
                x: 45
                y: 578
                text: qsTr("E - enzyme")
                font.pixelSize: 16
            }

            Text {
                id: legendProductText
                x: 45
                y: 607
                text: qsTr("P - product")
                font.pixelSize: 16
            }

            Text {
                id: k_1Const
                x: 135
                y: 108
                text: qsTr("k<sub>-1</sub>")
                font.pixelSize: 18
            }

            Text {
                id: k2Const
                x: 233
                y: 61
                text: qsTr("k<sub>2</sub>")
                font.pixelSize: 18
            }

            Text {
                id: k3Const
                x: 149
                y: 190
                text: qsTr("k<sub>3</sub>")
                font.pixelSize: 18
            }

            Text {
                id: k_3Const
                x: 149
                y: 237
                text: qsTr("k<sub>-3</sub>")
                font.pixelSize: 18
            }

            Text {
                id: k4Const
                x: 135
                y: 321
                text: qsTr("k<sub>4</sub>")
                font.pixelSize: 18
            }

            Text {
                id: k_4Const
                x: 135
                y: 368
                text: qsTr("k<sub>-4</sub>")
                font.pixelSize: 18
            }

            Rectangle {
                id: substrateCheckbox
                x: 356
                y: 214
                width: 20
                height: 20
                radius: 6
                border.color: "#000000"
                state: "SUBSTRATE_INHIBITION_ENABLED"

                states: [
                    State {
                        name: "SUBSTRATE_INHIBITION_ENABLED"
                        PropertyChanges { target: substrateCheckbox; color: "green"}
                        PropertyChanges { target: substrateInhibitionText; color: "black"}
                        PropertyChanges { target: substrateInhibitionReaction; color: "black"}
                        PropertyChanges { target: k3Const; color: "black"}
                        PropertyChanges { target: k_3Const; color: "black"}
                        PropertyChanges { target: k3ConstantText; color: "black"}
                        PropertyChanges { target: k_3ConstantText; color: "black"}
                        PropertyChanges { target: k3UnitsText; color: "black"}
                        PropertyChanges { target: k_3UnitsText; color: "black"}
                        PropertyChanges { target: kSConstantText; color: "black"}
                        PropertyChanges { target: kSNumeratorText; color: "black"}
                        PropertyChanges { target: kSDenominatorText; color: "black"}
                        PropertyChanges { target: kSEqualText; color: "black"}
                        PropertyChanges { target: kSUnitsText; color: "black"}
                        PropertyChanges { target: substrateConstantsText; color: "black"}
                        PropertyChanges { target: k3TextInput; readOnly: false}
                        PropertyChanges { target: k3TextInput; color: "black"}
                        PropertyChanges { target: k_3TextInput; readOnly: false}
                        PropertyChanges { target: k_3TextInput; color: "black"}
                        PropertyChanges { target: ksConstant; color: "black"}
                        PropertyChanges { target: ksFractionLine; color: "black"}
                        PropertyChanges { target: ksFractionLine; border.color: "black"}
                    },
                    State {
                        name: "SUBSTRATE_INHIBITION_DISABLED"
                        PropertyChanges { target: substrateCheckbox; color: "white"}
                        PropertyChanges { target: substrateInhibitionText; color: "grey"}
                        PropertyChanges { target: substrateInhibitionReaction; color: "grey"}
                        PropertyChanges { target: k3Const; color: "grey"}
                        PropertyChanges { target: k_3Const; color: "grey"}
                        PropertyChanges { target: k3ConstantText; color: "grey"}
                        PropertyChanges { target: k_3ConstantText; color: "grey"}
                        PropertyChanges { target: k3UnitsText; color: "grey"}
                        PropertyChanges { target: k_3UnitsText; color: "grey"}
                        PropertyChanges { target: kSConstantText; color: "grey"}
                        PropertyChanges { target: kSNumeratorText; color: "grey"}
                        PropertyChanges { target: kSDenominatorText; color: "grey"}
                        PropertyChanges { target: kSEqualText; color: "grey"}
                        PropertyChanges { target: kSUnitsText; color: "grey"}
                        PropertyChanges { target: substrateConstantsText; color: "grey"}
                        PropertyChanges { target: k3TextInput; readOnly: true}
                        PropertyChanges { target: k3TextInput; color: "grey"}
                        PropertyChanges { target: k_3TextInput; readOnly: true}
                        PropertyChanges { target: k_3TextInput; color: "grey"}
                        PropertyChanges { target: ksConstant; color: "grey"}
                        PropertyChanges { target: ksFractionLine; color: "grey"}
                        PropertyChanges { target: ksFractionLine; border.color: "grey"}
                    }
                ]

                MouseArea {
                    id: substrateCheckboxMouseArea
                    anchors.fill: parent
                    onClicked: {
                        if (substrateCheckbox.state == "SUBSTRATE_INHIBITION_ENABLED")
                            substrateCheckbox.state = "SUBSTRATE_INHIBITION_DISABLED"
                        else
                            substrateCheckbox.state = "SUBSTRATE_INHIBITION_ENABLED"
                    }
                }
            }

            Text {
                id: includeSubstrateInhibitionText
                x: 389
                y: 217
                text: qsTr("Include substrate inhibition")
                font.pixelSize: 12
            }

            Rectangle {
                id: productCheckbox
                x: 356
                y: 345
                width: 20
                height: 20
                radius: 6
                border.color: "#000000"
                state: "PRODUCT_INHIBITION_ENABLED"

                states: [
                    State {
                        name: "PRODUCT_INHIBITION_ENABLED"
                        PropertyChanges { target: productCheckbox; color: "green"}
                        PropertyChanges { target: productInhibitionText; color: "black"}
                        PropertyChanges { target: productInhibitionReaction; color: "black"}
                        PropertyChanges { target: k4Const; color: "black"}
                        PropertyChanges { target: k_4Const; color: "black"}
                        PropertyChanges { target: k4ConstantText; color: "black"}
                        PropertyChanges { target: k_4ConstantText; color: "black"}
                        PropertyChanges { target: k4UnitsText; color: "black"}
                        PropertyChanges { target: k_4UnitsText; color: "black"}
                        PropertyChanges { target: kPConstantText; color: "black"}
                        PropertyChanges { target: kPNumeratorText; color: "black"}
                        PropertyChanges { target: kPDenominatorText; color: "black"}
                        PropertyChanges { target: kPEqualText; color: "black"}
                        PropertyChanges { target: kPUnitsText; color: "black"}
                        PropertyChanges { target: productConstantsText; color: "black"}
                        PropertyChanges { target: k4TextInput; readOnly: false}
                        PropertyChanges { target: k4TextInput; color: "black"}
                        PropertyChanges { target: k_4TextInput; readOnly: false}
                        PropertyChanges { target: k_4TextInput; color: "black"}
                        PropertyChanges { target: kpConstant; color: "black"}
                        PropertyChanges { target: kpFractionLine; color: "black"}
                        PropertyChanges { target: kpFractionLine; border.color: "black"}
                    },
                    State {
                        name: "PRODUCT_INHIBITION_DISABLED"
                        PropertyChanges { target: productCheckbox; color: "white"}
                        PropertyChanges { target: productInhibitionText; color: "grey"}
                        PropertyChanges { target: productInhibitionReaction; color: "grey"}
                        PropertyChanges { target: k4Const; color: "grey"}
                        PropertyChanges { target: k_4Const; color: "grey"}
                        PropertyChanges { target: k4ConstantText; color: "grey"}
                        PropertyChanges { target: k_4ConstantText; color: "grey"}
                        PropertyChanges { target: k4UnitsText; color: "grey"}
                        PropertyChanges { target: k_4UnitsText; color: "grey"}
                        PropertyChanges { target: kPConstantText; color: "grey"}
                        PropertyChanges { target: kPNumeratorText; color: "grey"}
                        PropertyChanges { target: kPDenominatorText; color: "grey"}
                        PropertyChanges { target: kPEqualText; color: "grey"}
                        PropertyChanges { target: kPUnitsText; color: "grey"}
                        PropertyChanges { target: productConstantsText; color: "grey"}
                        PropertyChanges { target: k4TextInput; readOnly: true}
                        PropertyChanges { target: k4TextInput; color: "grey"}
                        PropertyChanges { target: k_4TextInput; readOnly: true}
                        PropertyChanges { target: k_4TextInput; color: "grey"}
                        PropertyChanges { target: kpConstant; color: "grey"}
                        PropertyChanges { target: kpFractionLine; color: "grey"}
                        PropertyChanges { target: kpFractionLine; border.color: "grey"}
                    }
                ]

                MouseArea {
                    id: productCheckboxMouseArea
                    anchors.fill: parent
                    onClicked: {
                        if (productCheckbox.state == "PRODUCT_INHIBITION_ENABLED")
                            productCheckbox.state = "PRODUCT_INHIBITION_DISABLED"
                        else
                            productCheckbox.state = "PRODUCT_INHIBITION_ENABLED"
                    }
                }
            }

            Text {
                id: includeProductInhibitionText
                x: 389
                y: 348
                text: qsTr("Include product inhibition")
                font.pixelSize: 12
            }

            Text {
                id: chargeTransferText
                x: 45
                y: 414
                text: qsTr("Electrones passed during a charge transfer on the electrode surface")
                font.pixelSize: 20
            }

            Text {
                id: electroneNumberText
                x: 302
                y: 462
                text: qsTr("n<sub>e</sub> = ")
                font.pixelSize: 18
            }

            TextInput {
                id: electroneNumberInput
                x: 345
                y: 462
                width: 26
                height: 21
                text: qsTr("1")
                font.pixelSize: 18
                validator: IntValidator {
                    bottom: 1
                }
                focus: true
            }

            Text {
                id: chargeTransferReaction
                x: 45
                y: 454
                text: qsTr("P (+/-) n<sub>e</sub> e<sup>-</sup>   →   P<sub>final</sub>")
                font.pixelSize: 30
            }

            Text {
                id: legendProductFinalText
                x: 45
                y: 636
                text: qsTr("P<sub>final</sub> - product of electrochemical reaction")
                font.pixelSize: 16
            }

        }

        Rectangle {
            id: geometryRectangle
            width: 649
            height: 518
            color: "#00000000"
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 30
            property variant layers

            ListModel {
                id: layersModel

                ListElement {
                    layerState: "ELECTRODE"
                    layerId: 0
                }

                ListElement {
                    layerState: "BULK_SOLUTION"
                    layerId: 1
                }
            }

            Component {
                id: layersDelegate
                Column {
                    id: layersDelegateRow
                    Component.onCompleted: {
                        var component = Qt.createComponent("SandwichComponent.qml");
                        var layer = component.createObject(layersDelegateRow, {"state": layerState, "layerId": layerId});
                    }
                }
            }

            ListView {
                id: layers
                x: 20
                y: 20
                width: 609
                height: 447
                interactive: false
                contentHeight: 0
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 51
                anchors.top: parent.top
                anchors.topMargin: 20
                model: layersModel
                delegate: layersDelegate
            }

            Rectangle {
                id: addEnzymeButton
                x: 311
                y: 478
                width: 150
                height: 30
                color: "#d3d3d3"
                radius: 6
                smooth: true
                border.color: "#000000"
                Text {
                    id: addEnzymeButtonText
                    x: 44
                    y: 15
                    text: qsTr("Add enzyme layer")
                    font.pixelSize: 12
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                MouseArea {
                    id: addEnzymeButtonMouseArea
                    x: 0
                    y: 0
                    hoverEnabled: true
                    anchors.fill: parent
                    anchors.topMargin: 0
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    onEntered: addEnzymeButton.color = "#6495ed"
                    onExited: addEnzymeButton.color = "#d3d3d3"
                    onClicked: {
                        var maxLayerId = 0;
                        for (var i = 0; i < layersModel.count; i++) {
                            if (layersModel.get(i).layerId > maxLayerId) {
                                maxLayerId = layersModel.get(i).layerId;
                            }
                        }
                        layersModel.insert(layersModel.count - 1, {layerState: "ENZYME_LAYER", layerId: maxLayerId + 1})
                    }
                }
                anchors.bottom: parent.bottom
                anchors.rightMargin: 188
                anchors.bottomMargin: 10
                anchors.right: parent.right
            }

            Rectangle {
                id: addDiffusiveButton
                x: 477
                y: 478
                width: 150
                height: 30
                color: "#d3d3d3"
                radius: 6
                smooth: true
                border.color: "#000000"
                Text {
                    id: addDiffusiveButtonText
                    x: 44
                    y: 15
                    text: qsTr("Add diffusive layer")
                    font.pixelSize: 12
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }

                MouseArea {
                    id: addDiffusiveButtonMouseArea
                    x: 0
                    y: 0
                    hoverEnabled: true
                    anchors.fill: parent
                    anchors.topMargin: 0
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    onEntered: addDiffusiveButton.color = "#6495ed"
                    onExited: addDiffusiveButton.color = "#d3d3d3"
                    onClicked: {
                        var maxLayerId = 0;
                        for (var i = 0; i < layersModel.count; i++) {
                            if (layersModel.get(i).layerId > maxLayerId) {
                                maxLayerId = layersModel.get(i).layerId;
                            }
                        }
                        layersModel.insert(layersModel.count - 1, {layerState: "DIFFUSIVE_LAYER", layerId: maxLayerId + 1});
                    }
                }
                anchors.bottom: parent.bottom
                anchors.rightMargin: 22
                anchors.bottomMargin: 10
                anchors.right: parent.right
            }

        }

        Rectangle {
            id: calculationsRectangle
            x: 0
            y: 30
            width: 200
            color: "#00000000"
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 30

            Text {
                id: responseTimeText
                x: 45
                y: 15
                text: qsTr("Response time")
                font.pixelSize: 20
            }

            Text {
                id: trText
                x: 45
                y: 52
                text: qsTr("t<sub>r</sub> = ")
                font.pixelSize: 18
            }

            TextInput {
                id: trTextInput
                x: 76
                y: 52
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
                id: trUnitsText
                x: 148
                y: 52
                width: 9
                height: 21
                text: qsTr("s")
                font.pixelSize: 18
            }

            Text {
                id: outputFileText
                x: 45
                y: 97
                text: qsTr("Output file")
                font.pixelSize: 20
            }

            TextInput {
                id: outputFileInput
                x: 45
                y: 133
                width: 613
                height: 21
                text: qsTr("output.dat")
                font.pixelSize: 18
                focus: true
            }
        }
    }

    Rectangle {
        id: bottomRectangle
        y: 500
        height: 49
        color: "#d3d3d3"
        anchors.right: parent.right
        anchors.rightMargin: 1
        anchors.left: parent.left
        anchors.leftMargin: 1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1

        Rectangle {
            id: runButton
            x: 416
            y: 10
            width: 70
            height: 30
            color: "#d3d3d3"
            radius: 6
            anchors.right: parent.right
            anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            smooth: true
            border.color: "#000000"
            Text {
                id: runButtonText
                x: 44
                y: 15
                text: qsTr("Run")
                font.pixelSize: 12
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                id: runButtonMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onEntered: runButton.color = "#6495ed"
                onExited: runButton.color = "#d3d3d3"
                onClicked: {
                    calculatorRunner.runCalculator(1, 2);
                }
            }
        }
    }
    states: [
        State {
            name: "REACTIONS"
            //Nuimamas ankstesnis pažymėjimas
            PropertyChanges {
                        target: kineticsButton
                        color: "#d3d3d3"
            }
            PropertyChanges {
                        target: geometryButton
                        color: "#d3d3d3"
            }
            PropertyChanges {
                        target: calculationsButton
                        color: "#d3d3d3"
            }
            //Pažymimas reactionsButton mygtukas
            PropertyChanges {
                        target: reactionsButton
                        color: "#6495ed"
            }
            //Pakeičiama antraštė
            PropertyChanges {
                        target: rightHeaderText
                        text: reactionsButtonText.text
            }
            //Parodoma atitinkama panelė
            PropertyChanges {
                        target: reactionRectangle
                        visible: true
            }
            PropertyChanges {
                        target: kineticsRectangle
                        visible: false
            }
            PropertyChanges {
                        target: geometryRectangle
                        visible: false
            }
            PropertyChanges {
                        target: calculationsRectangle
                        visible: false
            }
        },
        State {
            name: "KINETICS"
            //Nuimamas ankstesnis pažymėjimas
            PropertyChanges {
                target: reactionsButton
                color: "#d3d3d3"
            }
            PropertyChanges {
                target: geometryButton
                color: "#d3d3d3"
            }
            PropertyChanges {
                target: calculationsButton
                color: "#d3d3d3"
            }
            //Pažymimas kineticsButton mygtukas
            PropertyChanges {
                target: kineticsButton
                color: "#6495ed"
            }
            //Pakeičiama antraštė
            PropertyChanges {
                target: rightHeaderText
                text: kineticsButtonText.text
            }
            //Parodoma atitinkama panelė
            PropertyChanges {
                        target: reactionRectangle
                        visible: false
            }
            PropertyChanges {
                        target: kineticsRectangle
                        visible: true
            }
            PropertyChanges {
                        target: geometryRectangle
                        visible: false
            }
            PropertyChanges {
                        target: calculationsRectangle
                        visible: false
            }
        },
        State {
            name: "GEOMETRY"
            //Nuimamas ankstesnis pažymėjimas
            PropertyChanges {
                target: reactionsButton
                color: "#d3d3d3"
            }
            PropertyChanges {
                target: kineticsButton
                color: "#d3d3d3"
            }
            PropertyChanges {
                target: calculationsButton
                color: "#d3d3d3"
            }
            //Pažymimas geometryButton mygtukas
            PropertyChanges {
                target: geometryButton
                color: "#6495ed"
            }
            //Pakeičiama antraštė
            PropertyChanges {
                target: rightHeaderText
                text: geometryButtonText.text
            }
            //Parodoma atitinkama panelė
            PropertyChanges {
                        target: reactionRectangle
                        visible: false
            }
            PropertyChanges {
                        target: kineticsRectangle
                        visible: false
            }
            PropertyChanges {
                        target: geometryRectangle
                        visible: true
            }
            PropertyChanges {
                        target: calculationsRectangle
                        visible: false
            }
        },
        State {
            name: "CALCULATIONS"
            //Nuimamas ankstesnis pažymėjimas
            PropertyChanges {
                target: reactionsButton
                color: "#d3d3d3"
            }
            PropertyChanges {
                target: kineticsButton
                color: "#d3d3d3"
            }
            PropertyChanges {
                target: geometryButton
                color: "#d3d3d3"
            }
            //Pažymimas calculationsButton mygtukas
            PropertyChanges {
                target: calculationsButton
                color: "#6495ed"
            }
            //Pakeičiama antraštė
            PropertyChanges {
                target: rightHeaderText
                text: calculationsButtonText.text
            }
            //Parodoma atitinkama panelė
            PropertyChanges {
                        target: reactionRectangle
                        visible: false
            }
            PropertyChanges {
                        target: kineticsRectangle
                        visible: false
            }
            PropertyChanges {
                        target: geometryRectangle
                        visible: false
            }
            PropertyChanges {
                        target: calculationsRectangle
                        visible: true
            }
        }
    ]
}
