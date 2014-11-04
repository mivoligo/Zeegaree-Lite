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

    property bool isActive: false
    property alias buttonma: ma

    width: 16
    height: 16

    Rectangle {
        id: top_rect

        color: root.isActive ? styl.small_menu_button_active_color : styl.small_menu_button_color
        width: 14
        height: 2
        anchors {
            bottom: middle_rect.top
            bottomMargin: 2
            horizontalCenter: parent.horizontalCenter
        }
    }

    Rectangle {
        id: middle_rect

        color: top_rect.color
        width: 14
        height: 2
        anchors.centerIn: parent
    }

    Rectangle {
        id: bottom_rect

        color: top_rect.color
        width: 14
        height: 2
        anchors {
            top: middle_rect.bottom
            topMargin: 2
            horizontalCenter: parent.horizontalCenter
        }
    }

    MouseArea {
        id: ma

        anchors.fill: parent
    }
}
