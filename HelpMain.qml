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
    id: helpmain

    property alias text: text
    property alias helptext: text.text
    property alias helpnote: helpmain
    property alias backbutton: backbutton
    property alias forwardbutton: forwardbutton
    property alias ffclick: mouse_area2
    property alias backclick: mouse_area1
    property alias closeclick: closema

    color: "#222"
    opacity: 0
    width: 400
    height: text.height + 20
    radius: 4
    x: (parent.width - width)/2
    y:  - height - 40
    Behavior on height {
        NumberAnimation { easing.type: Easing.OutExpo; duration: 200}
    }

    Text {
        id: text

        color: "#fff"
        anchors {
            top: parent.top
            topMargin: 10
            left: parent.left
            leftMargin: 10
            right: parent.right
            rightMargin: 10
        }
        text: qsTr("")
        onLinkActivated: Qt.openUrlExternally(link)
        wrapMode: Text.WordWrap
        font {
            family: "Ubuntu Light"; pixelSize: 16
        }
    }

    CloseButtonSmall {
        id: closebutton

        color: "#e7e7e7"
        radius: 4
        width: 26
        height: 26
        anchors {
            bottom: parent.top
            bottomMargin: 5
            right: parent.right
        }

        MouseArea {
            id: closema
            anchors.fill: parent
        }
    }

    Rectangle {
        id: backbutton

        color: "#e7e7e7"
        opacity: 0
        width: 26
        height: 26
        radius: 4
        anchors {
            top: parent.bottom
            topMargin: 5
            left: parent.left
        }

        Image {
            id: backimage

            source: "images/back.png"
            anchors.centerIn: parent
        }

        MouseArea {
            id: mouse_area1

            anchors.fill: parent
        }
    }


    Rectangle {
        id: forwardbutton

        color: "#e7e7e7"
        opacity: 0
        width: 26
        height: 26
        radius: 4
        anchors {
            top: parent.bottom
            topMargin: 5
            right: parent.right
        }

        Image {
            id: forwardimage

            source: "images/forward.png"
            anchors.centerIn: parent
        }

        MouseArea {
            id: mouse_area2

            anchors.fill: parent
        }
    }

}
