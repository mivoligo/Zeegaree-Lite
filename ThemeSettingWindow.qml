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
import "Storage.js" as Storage
import "Theme.js" as Theme

Rectangle {
    id: edit_theme

    Behavior on scale {NumberAnimation{}}

    color: styl.dialog_back_color
    width: 400
    height: 200
    radius: 4

    Component.onCompleted:  {
        var theme = Storage.getSetting("selected_theme")
        if (theme == day_theme.text){
            Theme.setDayTheme()
        }
        else  {
            Theme.setNightTheme()
        }
    }

    Text {
        id: setting_name

        color: styl.text_color_secondary
        anchors {
            top: parent.top
            topMargin: 18
            horizontalCenter: parent.horizontalCenter
        }

        text: qsTr("Theme")
        font {pixelSize: 18; family: "Ubuntu Light"}
    }

    DividerSmallHor {
        id: divider1

        width: parent.width - 24
        anchors {
            top: setting_name.bottom
            topMargin: 12
            horizontalCenter: parent.horizontalCenter
        }
    }

    Rectangle {
        id: selected_night

        visible: night_theme.isSelected
        color: night_theme.color
        width: 10
        height: width
        radius: width/2
        anchors {
            right: night_theme.left
            rightMargin: 12
            verticalCenter: night_theme.verticalCenter
        }
        smooth: true
    }

    Text {
        id: night_theme

        property bool isSelected

        color: styl.text_color_primary
        anchors {
            top: setting_name.bottom
            topMargin: 36
            horizontalCenter: parent.horizontalCenter
        }
        text: qsTr("Night")
        font {pixelSize: 20; family: "Ubuntu"}

        MouseArea {
            anchors.fill: parent

            onClicked: {
                night_theme.isSelected = true;
                day_theme.isSelected = false;
                Theme.setNightTheme();
                theme_setting.text = night_theme.text;
                theme_set_window.scale = 0;
                overlay.scale = 0;
                Storage.checkIfSettingExist("selected_theme") == "true" ? Storage.updateSettings("selected_theme", night_theme.text) :
                                                                          Storage.saveSetting("selected_theme", night_theme.text);
            }
        }
    }

    Rectangle {
        id: selected_day

        visible: day_theme.isSelected
        color: day_theme.color
        width: 10
        height: width
        radius: width/2
        anchors {
            right: day_theme.left
            rightMargin: 12
            verticalCenter: day_theme.verticalCenter
        }
        smooth: true
    }

    Text {
        id: day_theme

        property bool isSelected

        color: styl.text_color_primary
        anchors {
            top: night_theme.bottom
            topMargin: 12
            horizontalCenter: parent.horizontalCenter
        }
        text: qsTr("Day")
        font {pixelSize: 20; family: "Ubuntu"}
        MouseArea {
            anchors.fill: parent

            onClicked: {
                day_theme.isSelected = true;
                night_theme.isSelected = false;
                Theme.setDayTheme();
                theme_setting.text = day_theme.text;
                theme_set_window.scale = 0;
                overlay.scale = 0;
                Storage.checkIfSettingExist("selected_theme") == "true" ? Storage.updateSettings("selected_theme", day_theme.text) :
                                                                          Storage.saveSetting("selected_theme", day_theme.text);
            }
        }
    }


}
