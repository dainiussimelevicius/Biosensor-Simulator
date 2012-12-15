// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: page
    width: 800
    height: 600
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
            x: 0
            y: 42
            width: 649
            height: 518
            color: "#00000000"

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
                id: mainConstantsText1
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
                id: mainConstantsText4
                x: 154
                y: 53
                width: 34
                height: 21
                text: qsTr("mol<sup>-1</sup> ∙ l ∙ s<sup>-1</sup>")
                font.pixelSize: 18
            }

            Text {
                id: mainConstantsText2
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
                id: mainConstantsText5
                x: 154
                y: 87
                width: 34
                height: 21
                text: qsTr("s<sup>-1</sup>")
                font.pixelSize: 18
            }

            Text {
                id: mainConstantsText3
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
                id: mainConstantsText6
                x: 154
                y: 121
                width: 34
                height: 21
                text: qsTr("s<sup>-1</sup>")
                font.pixelSize: 18
            }

            Text {
                id: mainConstantsText7
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
                id: mainConstantsText8
                x: 356
                y: 77
                text: qsTr("k<sub>-1</sub> + k<sub>2</sub>")
                font.pixelSize: 18
            }

            Text {
                id: mainConstantsText9
                x: 375
                y: 100
                text: qsTr("k<sub>1</sub>")
                font.pixelSize: 18
            }

            Text {
                id: mainConstantsText10
                x: 424
                y: 87
                text: qsTr(" = ")
                font.pixelSize: 18
            }

            Text {
                id: mainConstantsText12
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
                id: substrateConstantsText1
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
                id: substrateConstantsText3
                x: 154
                y: 204
                width: 34
                height: 21
                text: qsTr("mol<sup>-1</sup> ∙ l ∙ s<sup>-1</sup>")
                font.pixelSize: 18
            }

            Text {
                id: substrateConstantsText2
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
                id: substrateConstantsText4
                x: 154
                y: 238
                width: 34
                height: 21
                text: qsTr("s<sup>-1</sup>")
                font.pixelSize: 18
            }

            Text {
                id: substrateConstantsText5
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
                id: substrateConstantsText6
                x: 356
                y: 212
                text: qsTr("k<sub>-3</sub>")
                font.pixelSize: 18
            }

            Text {
                id: substrateConstantsText7
                x: 356
                y: 233
                text: qsTr("k<sub>3</sub>")
                font.pixelSize: 18
            }

            Text {
                id: substrateConstantsText8
                x: 391
                y: 222
                text: qsTr(" = ")
                font.pixelSize: 18
            }

            Text {
                id: substrateConstantsText10
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
                id: productConstantsText1
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
                id: productConstantsText3
                x: 154
                y: 316
                width: 34
                height: 21
                text: qsTr("mol<sup>-1</sup> ∙ l ∙ s<sup>-1</sup>")
                font.pixelSize: 18
            }

            Text {
                id: productConstantsText2
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
                id: productConstantsText4
                x: 154
                y: 350
                width: 34
                height: 21
                text: qsTr("s<sup>-1</sup>")
                font.pixelSize: 18
            }

            Text {
                id: productConstantsText5
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
                id: productConstantsText6
                x: 356
                y: 324
                text: qsTr("k<sub>-4</sub>")
                font.pixelSize: 18
            }

            Text {
                id: productConstantsText7
                x: 356
                y: 345
                text: qsTr("k<sub>4</sub>")
                font.pixelSize: 18
            }

            Text {
                id: productConstantsText8
                x: 391
                y: 334
                text: qsTr(" = ")
                font.pixelSize: 18
            }

            Text {
                id: productConstantsText10
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
                id: mainConstantsText13
                x: 39
                y: 15
                text: qsTr("Reaction rate constants of Michaelis-Menten equation")
                font.pixelSize: 20
            }

            Text {
                id: substrateConstantsText11
                x: 39
                y: 163
                text: qsTr("Reaction rate constants of substrate inhibition equations")
                font.pixelSize: 20
            }

            Text {
                id: productConstantsText11
                x: 39
                y: 277
                text: qsTr("Reaction rate constants of product inhibition equations")
                font.pixelSize: 20
            }
        }

        Rectangle {
            id: reactionRectangle
            x: 0
            y: 30
            width: 649
            height: 518
            color: "#00000000"

            Text {
                id: mainText3
                x: 135
                y: 61
                text: qsTr("k<sub>1</sub>")
                font.pixelSize: 18
            }

            Text {
                id: mainText2
                x: 45
                y: 77
                text: qsTr("E + S   ⇄   ES   →   E + P")
                font.pixelSize: 30
            }

            Text {
                id: substrateText2
                x: 45
                y: 206
                text: qsTr("ES + S   ⇄   ESS")
                font.pixelSize: 30
            }

            Text {
                id: productText2
                x: 45
                y: 337
                text: qsTr("E + P   ⇄   EP")
                font.pixelSize: 30
            }

            Text {
                id: mainText1
                x: 45
                y: 15
                text: qsTr("Michaelis-Menten equation")
                font.pixelSize: 20
            }

            Text {
                id: substrateText1
                x: 45
                y: 155
                text: qsTr("Equation of substrate inhibition")
                font.pixelSize: 20
            }

            Text {
                id: productText1
                x: 45
                y: 285
                text: qsTr("Equation of product inhibition")
                font.pixelSize: 20
            }

            Text {
                id: legendText1
                x: 45
                y: 410
                text: qsTr("S - substrate")
                font.pixelSize: 16
            }

            Text {
                id: legendText2
                x: 45
                y: 437
                text: qsTr("E - enzyme")
                font.pixelSize: 16
            }

            Text {
                id: legendText3
                x: 45
                y: 466
                text: qsTr("P - product")
                font.pixelSize: 16
            }

            Text {
                id: mainText4
                x: 135
                y: 108
                text: qsTr("k<sub>-1</sub>")
                font.pixelSize: 18
            }

            Text {
                id: mainText5
                x: 233
                y: 61
                text: qsTr("k<sub>2</sub>")
                font.pixelSize: 18
            }

            Text {
                id: substrateText3
                x: 149
                y: 190
                text: qsTr("k<sub>3</sub>")
                font.pixelSize: 18
            }

            Text {
                id: substrateText4
                x: 149
                y: 237
                text: qsTr("k<sub>-3</sub>")
                font.pixelSize: 18
            }

            Text {
                id: productText3
                x: 135
                y: 321
                text: qsTr("k<sub>4</sub>")
                font.pixelSize: 18
            }

            Text {
                id: productText4
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
                        PropertyChanges { target: substrateText1; color: "black"}
                        PropertyChanges { target: substrateText2; color: "black"}
                        PropertyChanges { target: substrateText3; color: "black"}
                        PropertyChanges { target: substrateText4; color: "black"}
                        PropertyChanges { target: substrateConstantsText1; color: "black"}
                        PropertyChanges { target: substrateConstantsText2; color: "black"}
                        PropertyChanges { target: substrateConstantsText3; color: "black"}
                        PropertyChanges { target: substrateConstantsText4; color: "black"}
                        PropertyChanges { target: substrateConstantsText5; color: "black"}
                        PropertyChanges { target: substrateConstantsText6; color: "black"}
                        PropertyChanges { target: substrateConstantsText7; color: "black"}
                        PropertyChanges { target: substrateConstantsText8; color: "black"}
                        PropertyChanges { target: substrateConstantsText10; color: "black"}
                        PropertyChanges { target: substrateConstantsText11; color: "black"}
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
                        PropertyChanges { target: substrateText1; color: "grey"}
                        PropertyChanges { target: substrateText2; color: "grey"}
                        PropertyChanges { target: substrateText3; color: "grey"}
                        PropertyChanges { target: substrateText4; color: "grey"}
                        PropertyChanges { target: substrateConstantsText1; color: "grey"}
                        PropertyChanges { target: substrateConstantsText2; color: "grey"}
                        PropertyChanges { target: substrateConstantsText3; color: "grey"}
                        PropertyChanges { target: substrateConstantsText4; color: "grey"}
                        PropertyChanges { target: substrateConstantsText5; color: "grey"}
                        PropertyChanges { target: substrateConstantsText6; color: "grey"}
                        PropertyChanges { target: substrateConstantsText7; color: "grey"}
                        PropertyChanges { target: substrateConstantsText8; color: "grey"}
                        PropertyChanges { target: substrateConstantsText10; color: "grey"}
                        PropertyChanges { target: substrateConstantsText11; color: "grey"}
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
                id: substrateText5
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
                        PropertyChanges { target: productText1; color: "black"}
                        PropertyChanges { target: productText2; color: "black"}
                        PropertyChanges { target: productText3; color: "black"}
                        PropertyChanges { target: productText4; color: "black"}
                        PropertyChanges { target: productConstantsText1; color: "black"}
                        PropertyChanges { target: productConstantsText2; color: "black"}
                        PropertyChanges { target: productConstantsText3; color: "black"}
                        PropertyChanges { target: productConstantsText4; color: "black"}
                        PropertyChanges { target: productConstantsText5; color: "black"}
                        PropertyChanges { target: productConstantsText6; color: "black"}
                        PropertyChanges { target: productConstantsText7; color: "black"}
                        PropertyChanges { target: productConstantsText8; color: "black"}
                        PropertyChanges { target: productConstantsText10; color: "black"}
                        PropertyChanges { target: productConstantsText11; color: "black"}
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
                        PropertyChanges { target: productText1; color: "grey"}
                        PropertyChanges { target: productText2; color: "grey"}
                        PropertyChanges { target: productText3; color: "grey"}
                        PropertyChanges { target: productText4; color: "grey"}
                        PropertyChanges { target: productConstantsText1; color: "grey"}
                        PropertyChanges { target: productConstantsText2; color: "grey"}
                        PropertyChanges { target: productConstantsText3; color: "grey"}
                        PropertyChanges { target: productConstantsText4; color: "grey"}
                        PropertyChanges { target: productConstantsText5; color: "grey"}
                        PropertyChanges { target: productConstantsText6; color: "grey"}
                        PropertyChanges { target: productConstantsText7; color: "grey"}
                        PropertyChanges { target: productConstantsText8; color: "grey"}
                        PropertyChanges { target: productConstantsText10; color: "grey"}
                        PropertyChanges { target: productConstantsText11; color: "grey"}
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
                id: productText5
                x: 389
                y: 348
                text: qsTr("Include product inhibition")
                font.pixelSize: 12
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
        }
    ]
}
