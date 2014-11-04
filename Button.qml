/****************************************************************************

Copyright 2013-2014 Michał Prędotka

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

****************************************************************************/
import QtQuick 1.1
Item {
    id: root

    property alias buttonimage: image
    property alias buttontext: text.text
    property alias buttontextcolor: text.color
    property alias button_ma: button_ma
    property color buttoncolor: styl.button_back_color
    property color buttonaccentcolor: styl.button_back_color_accent
    property bool isActive: button_ma.containsMouse || root.focus == true

    width: text.text !== "" ? text.width + 24 : image.width + 12
    height: 30

    Behavior on scale { NumberAnimation {duration: 100}}

    Keys.onEnterPressed: button_ma.clicked(true)
    Keys.onReturnPressed: button_ma.clicked(true)


    Rectangle {
        id: button_border

        visible: isActive
        color: buttonaccentcolor
        width: parent.width
        height: parent.height
        radius: 5
    }

    Rectangle {
        id: button_main

        color: isActive ? Qt.darker(buttoncolor, 1.2) : buttoncolor

        width: parent.width - 4
        height: 26
        radius: 4
        smooth: true
        anchors.centerIn: parent


        Image {
            id: image

            anchors.centerIn: parent
            source: ""
        }

        Text {
            id: text

            color: root.isActive ? styl.button_text_color_active : styl.button_text_color
            anchors.centerIn: parent
            text: ""
            font {pixelSize: 14; family: "Ubuntu"}
        }

        MouseArea {
            id: button_ma

            anchors.fill: parent
            hoverEnabled: true
            onClicked: root.focus = false
        }


    }


}

