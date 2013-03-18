// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: page
    width: 1024
    height: 768
    color: "#000000"
    state: "REACTIONS"

    function checkTimeStepCurrectness() {
        if (explicitSchemeCheckbox.state == "EXPLICIT_SCHEME") {
            //[s]
            var timeStep = parseFloat(timeStepInput.text.replace(",", "."));
            var minTimeStep = timeStep;
            var N = parseInt(gridPointsInput.text);
            var Ds; var Dp; var d; var spaceStep; var requiredTimeStep;
            for (var i = 1; i < layersModel.count - 1; i++) {
                //[um^2/s]
                Ds = layersModel.get(i).Ds;
                //[um^2/s]
                Dp = layersModel.get(i).Dp;
                //[um]
                d = layersModel.get(i).d;
                //[um]
                spaceStep = d / N;

                if ((Ds == 0) || (Dp == 0))
                    break;

                //Apskaičiuojame maksimalų žingsnio dydį substratui
                requiredTimeStep = (spaceStep * spaceStep) / (2 * Ds);
                if (requiredTimeStep < minTimeStep)
                    minTimeStep = requiredTimeStep;
                //Apskaičiuojame maksimalų žingsnio dydį produktui
                requiredTimeStep = (spaceStep * spaceStep) / (2 * Dp);
                if (requiredTimeStep < minTimeStep)
                    minTimeStep = requiredTimeStep;
            }
            //Informuojame vartotoją kokį žingsnį pagal laiką reikėtų parinkti
            if (timeStep > minTimeStep) {
                tooBigTimeStepWarning.text = qsTr("Time step may be too big (suggested time step is ≤ " + minTimeStep + ")");
                tooBigTimeStepWarning.visible = true;
            }
            else {
                tooBigTimeStepWarning.visible = false;
            }
        }
        else {
            tooBigTimeStepWarning.visible = false;
        }
    }

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
                text: qsTr("Reaction rate constants of biocatalytic reaction")
                font.pixelSize: 20
            }

            Text {
                id: substrateConstantsText
                x: 39
                y: 163
                text: qsTr("Reaction rate constants of substrate inhibition reaction")
                font.pixelSize: 20
            }

            Text {
                id: productConstantsText
                x: 39
                y: 277
                text: qsTr("Reaction rate constants of product inhibition reaction")
                font.pixelSize: 20
            }

            Rectangle {
                id: k_4TextInputRectangle
                x: 77
                y: 350
                width: 72
                height: 21
                color: "#ffffff"
                radius: 6
                border.width: 4
                border.color: "green"

                TextInput {
                    id: k_4TextInput
                    text: qsTr("0")
                    anchors.rightMargin: 2
                    anchors.leftMargin: 2
                    anchors.fill: parent
                    font.pixelSize: 18
                    validator: DoubleValidator{bottom: 0;}
                    focus: true
                    Keys.onReleased: {
                        if (k_4TextInput.acceptableInput) {
                            kpConstant.text = constantCalculator.calculateKInhibition(k4TextInput.text, k_4TextInput.text);
                        }
                    }
                }
            }

            Rectangle {
                id: k4TextInputRectangle
                x: 77
                y: 316
                width: 72
                height: 21
                color: "#ffffff"
                radius: 6
                border.width: 4
                border.color: "#008000"

                TextInput {
                    id: k4TextInput
                    text: qsTr("0")
                    anchors.rightMargin: 2
                    anchors.leftMargin: 2
                    anchors.fill: parent
                    font.pixelSize: 18
                    validator: DoubleValidator{bottom: 0;}
                    focus: true
                    Keys.onReleased: {
                        if (k4TextInput.acceptableInput) {
                            kpConstant.text = constantCalculator.calculateKInhibition(k4TextInput.text, k_4TextInput.text);
                        }
                    }
                }
            }

            Rectangle {
                id: k_3TextInputRectangle
                x: 77
                y: 238
                width: 72
                height: 21
                color: "#ffffff"
                radius: 6
                border.width: 4
                border.color: "#008000"

                TextInput {
                    id: k_3TextInput
                    text: qsTr("0")
                    anchors.rightMargin: 2
                    anchors.leftMargin: 2
                    anchors.fill: parent
                    font.pixelSize: 18
                    validator: DoubleValidator{bottom: 0;}
                    focus: true
                    Keys.onReleased: {
                        if (k_3TextInput.acceptableInput) {
                            ksConstant.text = constantCalculator.calculateKInhibition(k3TextInput.text, k_3TextInput.text);
                        }
                    }
                }
            }

            Rectangle {
                id: k3TextInputRectangle
                x: 77
                y: 204
                width: 72
                height: 21
                color: "#ffffff"
                radius: 6
                border.width: 4
                border.color: "#008000"

                TextInput {
                    id: k3TextInput
                    text: qsTr("0")
                    anchors.rightMargin: 2
                    anchors.leftMargin: 2
                    anchors.fill: parent
                    font.pixelSize: 18
                    validator: DoubleValidator{bottom: 0;}
                    focus: true
                    Keys.onReleased: {
                        if (k3TextInput.acceptableInput) {
                            ksConstant.text = constantCalculator.calculateKInhibition(k3TextInput.text, k_3TextInput.text);
                        }
                    }
                }
            }

            Rectangle {
                id: k2TextInputRectangle
                x: 77
                y: 121
                width: 72
                height: 21
                color: "#ffffff"
                radius: 6
                border.width: 4
                border.color: "#008000"

                TextInput {
                    id: k2TextInput
                    text: qsTr("0")
                    anchors.rightMargin: 2
                    anchors.leftMargin: 2
                    anchors.fill: parent
                    font.pixelSize: 18
                    validator: DoubleValidator{bottom: 0;}
                    focus: true
                    Keys.onReleased: {
                        if (k2TextInput.acceptableInput) {
                            kmConstant.text = constantCalculator.calculateKm(k1TextInput.text, k_1TextInput.text, k2TextInput.text);
                        }
                    }
                }
            }

            Rectangle {
                id: k_1TextInputRectangle
                x: 77
                y: 87
                width: 72
                height: 21
                color: "#ffffff"
                radius: 6
                border.width: 4
                border.color: "#008000"

                TextInput {
                    id: k_1TextInput
                    text: qsTr("0")
                    anchors.rightMargin: 2
                    anchors.leftMargin: 2
                    anchors.fill: parent
                    font.pixelSize: 18
                    validator: DoubleValidator{bottom: 0;}
                    focus: true
                    Keys.onReleased: {
                        if (k_1TextInput.acceptableInput) {
                            kmConstant.text = constantCalculator.calculateKm(k1TextInput.text, k_1TextInput.text, k2TextInput.text);
                        }
                    }
                }
            }

            Rectangle {
                id: k1TextInputRectangle
                x: 77
                y: 53
                width: 72
                height: 21
                color: "#ffffff"
                radius: 6
                border.width: 4
                border.color: "#008000"

                TextInput {
                    id: k1TextInput
                    text: qsTr("0")
                    anchors.rightMargin: 2
                    anchors.leftMargin: 2
                    anchors.fill: parent
                    font.pixelSize: 18
                    validator: DoubleValidator{bottom: 0;}
                    focus: true
                    Keys.onReleased: {
                        if (k1TextInput.acceptableInput) {
                            kmConstant.text = constantCalculator.calculateKm(k1TextInput.text, k_1TextInput.text, k2TextInput.text);
                        }
                    }
                }
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
                text: qsTr("Biocatalytic reaction")
                font.pixelSize: 20
            }

            Text {
                id: substrateInhibitionText
                x: 45
                y: 155
                text: qsTr("Substrate inhibition reaction")
                font.pixelSize: 20
            }

            Text {
                id: productInhibitionText
                x: 45
                y: 285
                text: qsTr("Product inhibition reaction")
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
                text: qsTr("Electrones passed during a charge transfer on an electrode surface")
                font.pixelSize: 20
            }

            Text {
                id: electroneNumberText
                x: 356
                y: 462
                text: qsTr("n<sub>e</sub> = ")
                font.pixelSize: 18
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

            Rectangle {
                id: electroneNumberInputRectangle
                x: 397
                y: 462
                width: 30
                height: 21
                color: "#ffffff"
                radius: 6
                border.width: 4
                border.color: "green"

                TextInput {
                    id: electroneNumberInput
                    text: qsTr("1")
                    horizontalAlignment: TextInput.AlignHCenter
                    anchors.rightMargin: 2
                    anchors.leftMargin: 2
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                    anchors.fill: parent
                    font.pixelSize: 18
                    validator: IntValidator {
                        bottom: 1
                    }
                    focus: true
                }
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
                    s0: 0
                    p0: 0
                }
            }

            Component {
                id: layersDelegate
                Column {
                    id: layersDelegateColumn
                    Component.onCompleted: {
                        var component = Qt.createComponent("SandwichComponent.qml");
                        var layer = component.createObject(layersDelegateColumn, {"state": layerState, "layerId": layerId});
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
                        layersModel.insert(layersModel.count - 1, {layerState: "ENZYME_LAYER", layerId: maxLayerId + 1, Ds: 0, Dp: 0, d: 0, e0: 0})
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
                        layersModel.insert(layersModel.count - 1, {layerState: "DIFFUSIVE_LAYER", layerId: maxLayerId + 1, Ds: 0, Dp: 0, d: 0});
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
                y: 304
                text: qsTr("Response time")
                font.pixelSize: 20
            }

            Text {
                id: trText
                x: 306
                y: 411
                text: qsTr("t<sub>r</sub> = ")
                font.pixelSize: 18
            }


            Text {
                id: trUnitsText
                x: 426
                y: 411
                width: 9
                height: 21
                text: qsTr("s")
                font.pixelSize: 18
            }

            Text {
                id: outputFileText
                x: 45
                y: 459
                text: qsTr("Output file")
                font.pixelSize: 20
            }

            Rectangle {
                id: explicitSchemeCheckbox
                x: 45
                y: 55
                width: 20
                height: 20
                radius: 6
                border.color: "#000000"
                state: "EXPLICIT_SCHEME"

                states: [
                    State {
                        name: "EXPLICIT_SCHEME"
                        PropertyChanges { target: explicitSchemeCheckbox; color: "green"}
                    },
                    State {
                        name: "IMPLICIT_SCHEME"
                        PropertyChanges { target: explicitSchemeCheckbox; color: "white"}
                    }
                ]

                MouseArea {
                    id: explicitSchemeCheckboxMouseArea
                    anchors.fill: parent
                    onClicked: {
                        if (explicitSchemeCheckbox.state != "EXPLICIT_SCHEME") {
                            explicitSchemeCheckbox.state = "EXPLICIT_SCHEME";
                            implicitSchemeCheckbox.state = "EXPLICIT_SCHEME";
                        }
                        checkTimeStepCurrectness();
                    }
                }
            }

            Rectangle {
                id: implicitSchemeCheckbox
                x: 45
                y: 90
                width: 20
                height: 20
                radius: 6
                border.color: "#000000"
                state: "EXPLICIT_SCHEME"

                states: [
                    State {
                        name: "EXPLICIT_SCHEME"
                        PropertyChanges { target: implicitSchemeCheckbox; color: "white"}
                    },
                    State {
                        name: "IMPLICIT_SCHEME"
                        PropertyChanges { target: implicitSchemeCheckbox; color: "green"}
                    }
                ]

                MouseArea {
                    id: implicitSchemeCheckboxMouseArea
                    anchors.fill: parent
                    onClicked: {
                        if (implicitSchemeCheckbox.state != "IMPLICIT_SCHEME") {
                            implicitSchemeCheckbox.state = "IMPLICIT_SCHEME"
                            explicitSchemeCheckbox.state = "IMPLICIT_SCHEME";
                        }
                        checkTimeStepCurrectness();
                    }
                }
            }

            Text {
                id: explicitSchemeText
                x: 77
                y: 58
                text: qsTr("Use explicit scheme")
                font.pixelSize: 12
            }

            Text {
                id: implicitSchemeText
                x: 77
                y: 92
                text: qsTr("Use implicit scheme")
                font.pixelSize: 12
            }

            Text {
                id: schemeText
                x: 45
                y: 16
                text: qsTr("The type of finite difference scheme")
                font.pixelSize: 20
            }

            Text {
                id: timeStepText
                x: 45
                y: 129
                text: qsTr("Time step")
                font.pixelSize: 20
            }

            Text {
                id: timeStep
                x: 45
                y: 170
                text: qsTr("Δt = ")
                font.pixelSize: 18
            }

            Text {
                id: timeStepUnits
                x: 157
                y: 170
                width: 9
                height: 21
                text: qsTr("s")
                font.pixelSize: 18
            }

            Text {
                id: gridPointsText
                x: 45
                y: 214
                text: qsTr("Grid points for a layer")
                font.pixelSize: 20
            }

            Text {
                id: gridPoints
                x: 45
                y: 259
                text: qsTr("N = ")
                font.pixelSize: 18
            }

            Rectangle {
                id: timeStepInputRectangle
                x: 82
                y: 170
                width: 72
                height: 21
                color: "#ffffff"
                radius: 6
                border.width: 4
                border.color: "#008000"

                TextInput {
                    id: timeStepInput
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
                        checkTimeStepCurrectness();
                    }
                }
            }

            Rectangle {
                id: gridPointsInputRectangle
                x: 82
                y: 259
                width: 72
                height: 21
                color: "#ffffff"
                radius: 6
                border.width: 4
                border.color: "#008000"

                TextInput {
                    id: gridPointsInput
                    text: qsTr("200")
                    anchors.rightMargin: 2
                    anchors.leftMargin: 2
                    anchors.fill: parent
                    font.pixelSize: 18
                    validator: DoubleValidator {
                        bottom: 0
                    }
                    focus: true
                    Keys.onReleased: {
                        checkTimeStepCurrectness();
                    }
                }
            }

            Rectangle {
                id: outputFileInputRectangle
                x: 45
                y: 500
                width: 613
                height: 21
                color: "#ffffff"
                radius: 6
                border.width: 4
                border.color: "#008000"

                TextInput {
                    id: outputFileInput
                    text: qsTr("output.dat")
                    anchors.rightMargin: 2
                    anchors.leftMargin: 2
                    anchors.fill: parent
                    font.pixelSize: 18
                    focus: true
                }
            }

            Rectangle {
                id: defaultResponseTimeCheckbox
                x: 45
                y: 343
                width: 20
                height: 20
                color: "#ffffff"
                radius: 6
                border.color: "#000000"
                state: "DEFAULT_RESPONSE_TIME"

                states: [
                    State {
                        name: "DEFAULT_RESPONSE_TIME"
                        PropertyChanges { target: defaultResponseTimeCheckbox; color: "green"}
                    },
                    State {
                        name: "MIN_RESPONSE_TIME"
                        PropertyChanges { target: defaultResponseTimeCheckbox; color: "white"}
                    },
                    State {
                        name: "FIXED_RESPONSE_TIME"
                        PropertyChanges { target: defaultResponseTimeCheckbox; color: "white"}
                    }
                ]

                MouseArea {
                    id: defaultResponseTimeCheckboxMouseArea
                    anchors.fill: parent
                    onClicked: {
                        if (state != "DEFAULT_RESPONSE_TIME") {
                            defaultResponseTimeCheckbox.state = "DEFAULT_RESPONSE_TIME";
                            minTimeResponseTimeCheckbox.state = "DEFAULT_RESPONSE_TIME";
                            fixedResponseTimeCheckbox.state = "DEFAULT_RESPONSE_TIME";
                        }
                    }
                }
            }

            Rectangle {
                id: minTimeResponseTimeCheckbox
                x: 45
                y: 376
                width: 20
                height: 20
                color: "#ffffff"
                radius: 6
                border.color: "#000000"
                state: "DEFAULT_RESPONSE_TIME"

                states: [
                    State {
                        name: "DEFAULT_RESPONSE_TIME"
                        PropertyChanges { target: minTimeResponseTimeCheckbox; color: "white"}
                        PropertyChanges { target: tMinUnitsText; color: "grey"}
                        PropertyChanges { target: tMinText; color: "grey"}
                        PropertyChanges { target: minResponseTimeInput; color: "grey"}
                        PropertyChanges { target: minResponseTimeInput; readOnly: true}
                    },
                    State {
                        name: "MIN_RESPONSE_TIME"
                        PropertyChanges { target: minTimeResponseTimeCheckbox; color: "green"}
                        PropertyChanges { target: tMinUnitsText; color: "black"}
                        PropertyChanges { target: tMinText; color: "black"}
                        PropertyChanges { target: minResponseTimeInput; color: "black"}
                        PropertyChanges { target: minResponseTimeInput; readOnly: false}
                    },
                    State {
                        name: "FIXED_RESPONSE_TIME"
                        PropertyChanges { target: minTimeResponseTimeCheckbox; color: "white"}
                        PropertyChanges { target: tMinUnitsText; color: "grey"}
                        PropertyChanges { target: tMinText; color: "grey"}
                        PropertyChanges { target: minResponseTimeInput; color: "grey"}
                        PropertyChanges { target: minResponseTimeInput; readOnly: true}
                    }
                ]

                MouseArea {
                    id: minTimeResponseTimeCheckboxMouseArea
                    anchors.fill: parent
                    onClicked: {
                        if (state != "MIN_RESPONSE_TIME") {
                            defaultResponseTimeCheckbox.state = "MIN_RESPONSE_TIME";
                            minTimeResponseTimeCheckbox.state = "MIN_RESPONSE_TIME";
                            fixedResponseTimeCheckbox.state = "MIN_RESPONSE_TIME";
                        }
                    }
                }
            }

            Rectangle {
                id: fixedResponseTimeCheckbox
                x: 45
                y: 411
                width: 20
                height: 20
                color: "#ffffff"
                radius: 6
                border.color: "#000000"
                state: "DEFAULT_RESPONSE_TIME"

                states: [
                    State {
                        name: "DEFAULT_RESPONSE_TIME"
                        PropertyChanges { target: fixedResponseTimeCheckbox; color: "white"}
                        PropertyChanges { target: trUnitsText; color: "grey"}
                        PropertyChanges { target: trText; color: "grey"}
                        PropertyChanges { target: fixedResponseTimeInput; color: "grey"}
                        PropertyChanges { target: fixedResponseTimeInput; readOnly: true}
                    },
                    State {
                        name: "MIN_RESPONSE_TIME"
                        PropertyChanges { target: fixedResponseTimeCheckbox; color: "white"}
                        PropertyChanges { target: trUnitsText; color: "grey"}
                        PropertyChanges { target: trText; color: "grey"}
                        PropertyChanges { target: fixedResponseTimeInput; color: "grey"}
                        PropertyChanges { target: fixedResponseTimeInput; readOnly: true}
                    },
                    State {
                        name: "FIXED_RESPONSE_TIME"
                        PropertyChanges { target: fixedResponseTimeCheckbox; color: "green"}
                        PropertyChanges { target: trUnitsText; color: "black"}
                        PropertyChanges { target: trText; color: "black"}
                        PropertyChanges { target: fixedResponseTimeInput; color: "black"}
                        PropertyChanges { target: fixedResponseTimeInput; readOnly: false}
                    }
                ]

                MouseArea {
                    id: fixedResponseTimeCheckboxMouseArea
                    anchors.fill: parent
                    onClicked: {
                        if (state != "FIXED_RESPONSE_TIME") {
                            defaultResponseTimeCheckbox.state = "FIXED_RESPONSE_TIME";
                            minTimeResponseTimeCheckbox.state = "FIXED_RESPONSE_TIME";
                            fixedResponseTimeCheckbox.state = "FIXED_RESPONSE_TIME";
                        }
                    }
                }
            }

            Text {
                id: defaultResponseTimeText
                x: 72
                y: 346
                text: qsTr("Until steady-state")
                font.pixelSize: 12
            }

            Text {
                id: minResponseTimeText
                x: 72
                y: 379
                text: qsTr("Until steady-state with minimum time")
                font.pixelSize: 12
            }

            Text {
                id: fixedResponseTimeText
                x: 72
                y: 414
                text: qsTr("Fixed response time")
                font.pixelSize: 12
            }

            Text {
                id: tMinText
                x: 306
                y: 376
                text: qsTr("t<sub>min</sub> = ")
                font.pixelSize: 18
            }

            Text {
                id: tMinUnitsText
                x: 426
                y: 376
                width: 9
                height: 21
                text: qsTr("s")
                font.pixelSize: 18
            }

            Rectangle {
                id: minResponseTimeInputRectangle
                x: 351
                y: 376
                width: 72
                height: 21
                color: "#ffffff"
                radius: 6
                border.width: 4
                border.color: "#008000"

                TextInput {
                    id: minResponseTimeInput
                    text: qsTr("0")
                    anchors.rightMargin: 2
                    anchors.leftMargin: 2
                    anchors.fill: parent
                    font.pixelSize: 18
                    validator: DoubleValidator {
                        bottom: 0
                    }
                    focus: true
                }
            }

            Rectangle {
                id: fixedResponseTimeInputRectangle
                x: 351
                y: 411
                width: 72
                height: 21
                color: "#ffffff"
                radius: 6
                border.color: "#008000"
                border.width: 4

                TextInput {
                    id: fixedResponseTimeInput
                    text: qsTr("0")
                    anchors.rightMargin: 2
                    anchors.leftMargin: 2
                    anchors.fill: parent
                    font.pixelSize: 18
                    validator: DoubleValidator {
                        bottom: 0
                    }
                    focus: true
                }
            }

            Text {
                id: tooBigTimeStepWarning
                x: 214
                y: 173
                text: qsTr("Time step may be too big")
                visible: false
                font.pixelSize: 12
                color: "red"
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
                    var maxProgressBarId = 0;
                    for (var i = 0; i < progressBarsModel.count; i++) {
                        if (progressBarsModel.get(i).progressBarId > maxProgressBarId) {
                            maxProgressBarId = progressBarsModel.get(i).progressBarId;
                        }
                    }
                    var newProgressBarId = maxProgressBarId + 1;
                    progressBarsModel.append({progressBarId: newProgressBarId});

                    var explicitScheme = explicitSchemeCheckbox.state == "EXPLICIT_SCHEME";
                    var substrateInhibition = substrateCheckbox.state == "SUBSTRATE_INHIBITION_ENABLED";
                    var productInhibition = productCheckbox.state == "PRODUCT_INHIBITION_ENABLED";
                    var k2 = parseFloat(k2TextInput.text.replace(",", "."));
                    var kM = parseFloat(kmConstant.text.replace(",", "."));
                    var kS = parseFloat(ksConstant.text.replace(",", "."));
                    var kP = parseFloat(kpConstant.text.replace(",", "."));
                    var timeStep = parseFloat(timeStepInput.text.replace(",", "."));
                    var N = parseInt(gridPointsInput.text);
                    var responseTimeMethod;
                    if (defaultResponseTimeCheckbox.state == "DEFAULT_RESPONSE_TIME")
                        responseTimeMethod = 0;
                    else if (defaultResponseTimeCheckbox.state == "MIN_RESPONSE_TIME")
                        responseTimeMethod = 1;
                    else //defaultResponseTimeCheckbox.state == "FIXED_RESPONSE_TIME"
                        responseTimeMethod = 2;
                    var minTime = parseFloat(minResponseTimeInput.text.replace(",", "."));
                    var responseTime = parseFloat(fixedResponseTimeInput.text.replace(",", "."));
                    var outputFileName = outputFileInput.text.toString();
                    var ne = parseInt(electroneNumberInput.text);
                    //Paskutinis sluoksnis visada yra tirpalo sluoksnis, todėl kreipiuosi layersModel.count - 1
                    var s0 = parseFloat(layersModel.get(layersModel.count - 1).s0.toString().replace(",", "."));
                    //Paskutinis sluoksnis visada yra tirpalo sluoksnis, todėl kreipiuosi layersModel.count - 1
                    var p0 = parseFloat(layersModel.get(layersModel.count - 1).p0.toString().replace(",", "."));
                    //Atmetu elektrodą ir tirpalo sluoksnį
                    var noOfBiosensorLayers = layersModel.count - 2;

                    calculator_runner.setBiosensorInformation(explicitScheme, //int explicitScheme
                                                             substrateInhibition, //int substrateInhibition
                                                             productInhibition, //int productInhibition
                                                             k2, //double k2
                                                             kM, //double kM
                                                             kS, //double kS
                                                             kP, //double kP
                                                             timeStep, //double timeStep
                                                             N, //int N gridPointsInput
                                                             responseTimeMethod, //int responseTimeMethod
                                                             minTime, //double minTime
                                                             responseTime, //double responseTime
                                                             outputFileName,
                                                             ne, //int ne
                                                             s0, //double s0
                                                             p0, //double p0
                                                             noOfBiosensorLayers); //int noOfBiosensorLayers

                    //Neimame pirmojo ir paskutiniojo sluoksnio, nes tai yra elektrodas ir tirpalas
                    var enzymeLayer; var Ds; var Dp; var d; var e0;
                    for (var i = 1; i < layersModel.count - 1; i++) {
                        enzymeLayer = layersModel.get(i).layerState == "ENZYME_LAYER";
                        Ds = layersModel.get(i).Ds;
                        Dp = layersModel.get(i).Dp;
                        d = layersModel.get(i).d;
                        e0 = 0;
                        if (enzymeLayer)
                          e0 = layersModel.get(i).e0;
                        calculator_runner.setLayerInformation(i - 1, enzymeLayer, Ds, Dp, d, e0);
                    }

                    calculator_runner.runCalculator(newProgressBarId);
                }
            }
        }

        ListModel {
            id: progressBarsModel
            //Iš pradžių nerodomas nė vienas progress bar'as
        }

        ListView {
            id: progressBarListView
            interactive: false
            orientation: ListView.Horizontal
            anchors.fill: parent
            delegate: Item {
                id: progressBarDelegate
                height: 40
                width: 110
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    width: 100
                    height: 40
                    color: "green"
                    radius: 6
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    id: simulationNo
                    text: qsTr("Simulation #" + progressBarId);
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 1

                }

                Text {
                    id: timeIndicator
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 1
                    font.pixelSize: 20
                    font.bold: true
                    Connections {
                        target: calculator_runner
                        onCrunched: {
                            if (id == progressBarId)
                                timeIndicator.text = qsTr(time + "s");
                        }
                    }
                }
            }
            model: progressBarsModel
            Connections {
                target: calculator_runner
                onFinished: {
                    for (var i = 0; i < progressBarsModel.count; i++) {
                        if (progressBarsModel.get(i).progressBarId == id) {
                            progressBarsModel.remove(i);
                            break;
                        }
                    }
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
