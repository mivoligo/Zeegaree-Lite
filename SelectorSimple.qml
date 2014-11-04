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

Rectangle {
    id: root

    property bool isSelected: false
    property bool isEditable: true
    property alias mouse_area: mouse_area1

    color: "#fff"
    width: 20
    height: 20
    radius: 4

    MouseArea {
        id: mouse_area1

        anchors.fill: parent
        enabled: root.isEditable
        hoverEnabled: true
        onEntered: root.color = "#eee"
        onExited: root.color = "#fff"
        onClicked: {
            root.isSelected === false ? root.isSelected = true : root.isSelected = false
        }
    }

    Image {
        id: image1

        visible: root.isSelected

        source: root.isEditable === true ? "images/selected_blue.png" : "images/selected_grey.png"
        smooth: true
        width: parent.width - 2
        height: width
        anchors.centerIn: parent
    }

}
