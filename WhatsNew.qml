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

    color: styl.back_color_primary
    width: 300
    height: 400

    Text {
        id: version_text

        color: styl.text_color_primary
        anchors {
            top: parent.top
            topMargin: 36
            horizontalCenter: parent.horizontalCenter
        }

        text: qsTr("Zeegaree Lite 1.2")
        font {pixelSize: 24; family: "Ubuntu"}
    }

    DividerSmallHor {
        id: divider1

        width: parent.width - 24
        anchors {
            top: version_text.bottom
            topMargin: 18
            horizontalCenter: parent.horizontalCenter
        }
    }

    Text {
        id: info_text

        color: styl.text_color_primary
        width: parent.width - 24
        anchors {
            top: divider1.bottom
            topMargin: 24
            horizontalCenter: parent.horizontalCenter
        }
        text: qsTr("If it is your first install, let me thank you for downloading the app. I hope you will enjoy it!")
        horizontalAlignment: Text.AlignHCenter
        font {pixelSize: 14; family: "Ubuntu"}
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
    }

    DividerSmallHor {
        id: divider2

        width: parent.width - 24
        anchors {
            top: info_text.bottom
            topMargin: 18
            horizontalCenter: parent.horizontalCenter
        }
    }

    Text {
        id: new_in_version_text

        color: styl.text_color_primary
        anchors {
            top: divider2.bottom
            topMargin: 24
            horizontalCenter: parent.horizontalCenter
        }

        text: qsTr("New in this version:")
        font {pixelSize: 18; family: "Ubuntu"}
    }

    Text {
        id: whats_new_text

        color: styl.text_color_primary
        width: parent.width - 96
        anchors {
            top: new_in_version_text.bottom
            topMargin: 12
            horizontalCenter: parent.horizontalCenter
        }

        text:
              "- option to select within couple colour themes for the program's look" + "\n" +
              "- redesigned Timer and Stopwatch" + "\n" +
              "- keyboard friendly way to set Timer" + "\n" +
              "- option to set digital mode" + "\n" +
              "- performance improvements" + "\n" +
              "- some bugs fixed"
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        font {pixelSize: 14; family: "Ubuntu"}
    }

    Button {
        id: ok_button

        width: 200
        anchors {
            bottom: parent.bottom
            bottomMargin: 24
            horizontalCenter: parent.horizontalCenter
        }

        buttoncolor: styl.button_back_color_ok
        buttontext: "OK, get me to Zeegaree Lite!"
        button_ma.onClicked: {
            whats_new.scale = 0
            whats_new.visible = false
        }
    }
}
