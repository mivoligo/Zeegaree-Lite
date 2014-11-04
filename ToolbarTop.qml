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

    property alias toolbarText: titleText.text
    property alias titletext: titleText

    width: 100
    height: 40

    Text {
        id: titleText

        color: styl.text_color_primary
        x: 12
        anchors.verticalCenter: parent.verticalCenter
        text: qsTr("text")
        font {family: "Ubuntu Light"; pixelSize: 24}
    }

}
