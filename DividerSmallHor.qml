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

    width: 1
    height: top_line.height + bottom_line.height
    Rectangle {
        id: top_line

        opacity: .5
        color: "#000"
        width: parent.width
        height: 1
    }

    Rectangle {
        id: bottom_line

        opacity: .1
        color: "#fff"
        width: parent.width
        height: 1
        anchors.top: top_line.bottom
    }
}
