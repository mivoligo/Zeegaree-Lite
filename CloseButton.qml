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
    id: rectangle1

    color: "#00000000"
    width: 30
    height: 30

    Rectangle {
        id: rectfirst

        color: rectangle1ma.containsMouse ? styl.close_button_active_color : styl.close_button_color // Change color on hover
        width: 8
        height: width
        radius: width/2
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.verticalCenter: parent.verticalCenter
    }

    Rectangle {
        color: rectfirst.color
        width: rectfirst.width
        height: rectfirst.height
        radius: rectfirst.radius
        anchors.centerIn: parent
    }

    Rectangle {
        color: rectfirst.color
        width: rectfirst.width
        height: rectfirst.height
        radius: rectfirst.radius
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.verticalCenter: parent.verticalCenter
    }

    MouseArea {
        id: rectangle1ma

        anchors.fill: parent
        hoverEnabled: true
    }

}
