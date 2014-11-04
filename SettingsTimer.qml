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


Item {
    id: root

    property alias repeat_alarm_setting: repeat_finished_edit

    DividerBigHor {
        id: big_divider1

        width: parent.width
    }

    Text {
        id: repeat_finished_setting

        color: styl.text_color_secondary
        width: parent.width - repeat_finished_edit.width - 36
        anchors {
            left: parent.left
            leftMargin: 12
            top: big_divider1.bottom
            topMargin: 12
        }

        text: qsTr("Repeat Alarm After Timer Finished")
        font {family: "Ubuntu"; pixelSize: 14}
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
    }

    SelectorSimple {
        id: repeat_finished_edit

        isSelected: true

        anchors {
            top: repeat_finished_setting.top
            right: parent.right
            rightMargin: 12
        }

        mouse_area.onClicked: Storage.checkIfSettingExist("repeat_alarm") == "true" ?
                                  Storage.updateSettings("repeat_alarm", repeat_finished_edit.isSelected):
                                  Storage.saveSetting("repeat_alarm", repeat_finished_edit.isSelected)
    }

    DividerSmallHor {
        id: divider_small1

        width: parent.width - 24
        anchors {
            top: repeat_finished_setting.bottom
            topMargin: 12
            left: parent.left
            leftMargin: 12
        }
    }
}
