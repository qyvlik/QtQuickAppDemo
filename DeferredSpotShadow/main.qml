/****************************************************************************
**
** Copyright (C) 2015 Klaralvdalens Datakonsult AB (KDAB).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt3D module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL3$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or later as published by the Free
** Software Foundation and appearing in the file LICENSE.GPL included in
** the packaging of this file. Please review the following information to
** ensure the GNU General Public License version 2.0 requirements will be
** met: http://www.gnu.org/licenses/gpl-2.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Scene3D 2.0
import QtQuick.Window 2.2

Window {

    id: root

    width: 900
    height: 600

    //@disable-check M16
    onClosing: {
        Qt.quit();
    }

    Rectangle {
        id: sceneBox
        width: Math.min(parent.width, parent.height)
        height: width

        Scene3D {
            anchors.fill: parent
            focus: true
            aspects: "input"

            DeferredScene {
                id: defScene
            }
        }
    }

    Rectangle {
        id: rightControls
        x: sceneBox.width
        width: parent.width - sceneBox.width
        height: parent.height

        color: "lightgray"

        Row {
            x: 20
            y: 20
            spacing: 10

            Button {
                text: qsTr("Add mesh")
                onClicked: {
                    defScene.addGenericMesh(Qt.resolvedUrl("./assets/suzanne.obj"));
                }
            }
            Button {
                text: qsTr("Add cube")
                onClicked: {
                    defScene.addCubeMesh();
                }
            }
            Button {
                text: qsTr("Add spotlight")
                onClicked: {
                    defScene.addSpotLight();
                }

            }
        }

        Rectangle {
            id: spotLightControls
            x: 20
            y: 60
            width: parent.width

            Text {
                text: qsTr("Spotlight controls");
            }
            GridLayout {
                y: 30
                columns: 2
                columnSpacing: 10
                width: parent.width - 40

                Text { text: "Red" }
                Slider {
                    id: redSlider
                    minimumValue: 0
                    maximumValue: 1
                    stepSize: 0.01
                    Layout.fillWidth: true
                    onValueChanged: {
                        defScene.setSpotLightColor(Qt.rgba(redSlider.value, greenSlider.value, blueSlider.value, 1.0))
                    }
                }

                Text { text: "Green" }
                Slider {
                    id: greenSlider
                    minimumValue: 0
                    maximumValue: 1
                    stepSize: 0.01
                    value: 1.0
                    Layout.fillWidth: true
                    onValueChanged: {
                        try {
                            defScene.setSpotLightColor(
                                        Qt.rgba(redSlider.value,
                                                greenSlider.value,
                                                blueSlider.value,
                                                1.0))
                        } catch(e) {
                            console.log(e)
                        }
                    }
                }

                Text { text: "Blue" }
                Slider {
                    id: blueSlider
                    minimumValue: 0
                    maximumValue: 1
                    stepSize: 0.01
                    Layout.fillWidth: true
                    onValueChanged: {
                        try {
                            defScene.setSpotLightColor(
                                        Qt.rgba(redSlider.value,
                                                greenSlider.value,
                                                blueSlider.value,
                                                1.0))
                        } catch(e){
                            console.log(e);
                        }
                    }
                }

                Text { text: "X Rotation" }
                Slider {
                    id: xRotSlider
                    minimumValue: 0
                    maximumValue: 360
                    stepSize: 1.0
                    Layout.fillWidth: true
                    onValueChanged: {
                        try {
                            defScene.setSpotLightRotation(value)
                        } catch(e){
                            console.log(e);
                        }
                    }
                }
            }
        }

    }

}
