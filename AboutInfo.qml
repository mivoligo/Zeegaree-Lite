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
    id: item1

    width: parent.width
    height: parent.height

    Rectangle {
        id: rectangle1

        color: styl.back_color_primary
        anchors.fill: parent
    }

    Item {
        id: container

        width: Math.min(parent.width, 600)
        height: parent.height
        anchors.centerIn: parent


        Image {
            id: logo

            source: "images/z-l_128.png"
            smooth: true
            fillMode: Image.PreserveAspectFit
            width: 100
            anchors {
                top: parent.top
                topMargin: 40
                left: parent.left
                leftMargin: 10
            }

            Behavior on rotation { NumberAnimation {duration: 500} }

            MouseArea {
                id: logoma

                anchors.fill: parent
                hoverEnabled: true
                onEntered: title.scale = 0.5
                onExited: title.scale = 1
            }
        }

        Text {
            id: title

            color: styl.text_color_primary
            anchors {
                top: parent.top
                topMargin: 40
                right: parent.right
                rightMargin: 10
            }
            text: qsTr("Zeegaree Lite 1.2")
            font.pixelSize: 32

            Behavior on scale { NumberAnimation {duration: 200} }

            MouseArea {
                id: titlema

                anchors.fill: parent
                hoverEnabled: true
                onEntered: logo.rotation = 720
                onExited: logo.rotation = 0
            }
        }

        Text {
            id: subtitle

            color: styl.text_color_secondary
            anchors {
                top: title.bottom
                topMargin: 5
                horizontalCenter: title.horizontalCenter
            }
            text: qsTr("Enjoy your time!")
            font {
                italic: true
                pixelSize: 18
            }
        }

        Text {
            id: program_website_link

            anchors {
                top: subtitle.bottom
                topMargin: 5
                horizontalCenter: subtitle.horizontalCenter
            }
            text: qsTr("<style type='text/css'>a:link {color:'#29C06E'}</style><a href = 'http://www.zeegaree.com'>Program website</a>")
            onLinkActivated: Qt.openUrlExternally(link)
            font.pixelSize: 14
        }

        Button {
            id: usc_link

            buttoncolor: styl.button_back_color_ok
            width: 140
            anchors {
                top: logo.bottom
                topMargin: 40
                left:logo.left
            }
            buttontext: "Write a review"

            button_ma.onClicked: Qt.openUrlExternally('apt://zeegaree-lite')
        }

        Button {
            id: donate_link

            buttoncolor: styl.button_back_color_ok
            width: 140
            anchors {
                top: logo.bottom
                topMargin: 40
                horizontalCenter: parent.horizontalCenter
            }
            buttontext: "Donate"

            button_ma.onClicked: Qt.openUrlExternally('http://zeegaree.com/donate/')
        }

        Button {
            id: usc_link_full_version

            buttoncolor: styl.button_back_color_ok
            width: 140
            anchors {
                top: logo.bottom
                topMargin: 40
                right: parent.right
                rightMargin: 10
            }
            buttontext: "Buy full version"

            button_ma.onClicked: Qt.openUrlExternally('apt://zeegaree')
        }

        Text {
            id: deskription

            color: styl.text_color_primary
            width: Math.min(700, parent.width - 20)
            anchors {
                top: usc_link.bottom
                topMargin: 20
                horizontalCenter: parent.horizontalCenter
            }
            text: qsTr("<style type='text/css'>a:link {color:'#29c06e'}</style>" +
                       "<p>Zeegaree Lite was designed and programmed with love, sweat and tears by Michal Predotka</p>" +
                       "Thank you for using Zeegaree Lite! " +
                       "If you find this program useful, you could go to the Ubuntu Software Center and give Zeegaree Lite good rating. " +
                       "It'll keep me motivated to improve the program and work on other exciting projects! " +
                       "You can contact me via email: <a href='mailto:zeegaree@gmail.com'>zeegaree@gmail.com</a>. Thank you! "+
                       "<p>Remember: you can get the full version of Zeegaree in the Ubuntu Software Center! "+
                       "Apart from the functionality available in Zeegaree Lite, it has a time management feature, so you can use it as a Pomodoro timer. "+
                       "Also the full version of Zeegaree will get more updates and support.</p>")
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            onLinkActivated: Qt.openUrlExternally(link)
            font.pixelSize: 14
        }

        Text {
            id: licence_text

            visible: false
            color: styl.text_color_primary
            width: Math.min(700, parent.width - 20)
            anchors {
                top: usc_link.bottom
                topMargin: 20
                horizontalCenter: parent.horizontalCenter
            }
            text: qsTr("<style type='text/css'>a:link {color:'#29c06e'}</style>" +
                       "<p>Copyright 2013 Michał Prędotka</p>"+
                       "<p>Licensed under the Apache License, Version 2.0 (the 'License'); " +
                       "you may not use this file except in compliance with the License. " +
                       "You may obtain a copy of the License at</p>" +
                       "<p><a href = 'http://www.apache.org/licenses/LICENSE-2.0'>http://www.apache.org/licenses/LICENSE-2.0</a></p>" +
                       "<p>Unless required by applicable law or agreed to in writing, software " +
                       "distributed under the License is distributed on an 'AS IS' BASIS, " +
                       "WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. " +
                       "See the License for the specific language governing permissions and " +
                       "limitations under the License.</p>")
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            onLinkActivated: Qt.openUrlExternally(link)
            font.pixelSize: 14
        }

        Text {
            id: credits_text

            visible: false
            color: styl.text_color_primary
            width: Math.min(700, parent.width - 20)
            anchors {
                top: usc_link.bottom
                topMargin: 20
                horizontalCenter: parent.horizontalCenter
            }
            text: qsTr("<style type='text/css'>a:link {color:'#29c06e'}</style>" +
                       "Code: Michał Prędotka" +"<br>" +
                       "Graphics: Michał Prędotka" +"<br>" +
                       "Special thanks to Izabela Latak, Jakub Grzesik and Szymon Waliczek for testing this program!" +"<br>" +
                       "Some icons based on <a href='http://www.webalys.com/minicons'>Minicons Free Vector Icons Pack</a>" +"<br>" +
                       "Sound samples from <a href='http://www.freesfx.co.uk'>http://www.freesfx.co.uk</a>")
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            onLinkActivated: Qt.openUrlExternally(link)
            font.pixelSize: 14
        }

        Button {
            id: licence_button

            buttoncolor: licence_button.button_ma.containsMouse || licence_text.visible ? styl.button_back_color_ok : styl.button_back_color
            width: 140
            anchors {
                bottom: copyright.top
                bottomMargin: 5
                left: parent.left
                leftMargin: 10
            }
            buttontext: "License"

            button_ma.onClicked: {
                credits_text.visible = false;
                if (licence_text.visible == true){
                    licence_text.visible = false;
                    deskription.visible = true;
                }
                else {
                    licence_text.visible = true;
                    deskription.visible = false
                }
            }
        }

        Button {
            id: credits_button

            buttoncolor: credits_button.button_ma.containsMouse || credits_text.visible ? styl.button_back_color_ok : styl.button_back_color
            width: 140
            anchors {
                bottom: copyright.top
                bottomMargin: 5
                right: parent.right
                rightMargin: 10
            }
            buttontext: "Credits"

            button_ma.onClicked: {
                licence_text.visible = false;
                if (credits_text.visible == true){
                    credits_text.visible = false;
                    deskription.visible = true;
                }
                else {
                    credits_text.visible = true;
                    deskription.visible = false
                }
            }
        }

        Text {
            id: copyright

            color: styl.text_color_secondary
            anchors {
                bottom: parent.bottom
                bottomMargin: 5
                horizontalCenter: parent.horizontalCenter
            }
            text: qsTr("© Copyright 2013 Michał Prędotka")
            font.pixelSize: 12
        }
    }

}
