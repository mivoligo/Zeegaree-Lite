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

Item {
    id: main_file

    property alias styles: styl
    property alias stopwatcher: stopwatchwindow.stopwatcher
    property alias stopwatchtime: stopwatchwindow.stext
    property alias timerer: timerwindow.timerer
    property alias timertime: timerwindow.ttext
    property alias timerstate: timerwindow.timerstate
    property alias favlistmodel: timerwindow.favlistmodel
    property alias favlistview: timerwindow.favlistview
    property alias lite_mode_edit: settings_window.lite_mode_edit

    function resetStopwatch() {stopwatcher.resetStopwatch()}

    function startStopwatch() {stopwatcher.startStopwatch()}

    function pauseStopwatch() {stopwatcher.pauseStopwatch()}

    function getLap() {stopwatcher.getLap()}

    function getSplit() {stopwatcher.getSplit()}

    function showTimer() {main_file.state = "timerBase"}

    function resetTimer() {timerer.resetTimer(); timerer.resetAlarmFlag()}

    function stopTimer() {timerer.stopTimer()}

    width: 800
    height: 600

    Component.onCompleted: {
        Storage.createSettingsTable();
        Storage.createFavsTable();
        if (Storage.checkIfDBVersionTableExists() == "not_exist"){
            console.log("table not exists")
            // news to user
            whats_new.scale = 1;
            whats_new.visible = true;
            //create table
            Storage.createDBVersionTable();
            //add value to table
            Storage.saveDBVersion(1);
        }
        else if (Storage.checkIfDBVersionTableExists() == "exist"){
            console.log("table exist")
        }
    }

    Styles {
        id: styl
    }

    Rectangle {
        id: alertrec

        color: "#78000000"
        visible: welcomewindow.height < 530 || welcomewindow.width < 780
        width: sizealert.width + 12
        height: sizealert.height + 10
        radius: 4
        anchors.centerIn: parent
        z: 1

        CloseButtonSmall {
            anchors {
                top: parent.top
                topMargin: 10
                right: parent.right
                rightMargin: 10
            }
        }

        MouseArea {
            id: alertrecma

            anchors.fill: parent
            onClicked: {
                alertrec.visible = false
            }
        }

        Text {
            id: sizealert

            color: styl.text_color_primary
            width: welcomewindow.width - 40
            anchors.centerIn: parent
            z: 2
            text: "Please, don't squeeze me too much! It makes me look bad."
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pixelSize: 40
        }
    }

    Rectangle {
        id: welcomewindow

        color: styl.back_color_primary

        width: parent.width
        height: parent.height

        /* ============================ Stopwatch ======================= */
        Rectangle {
            id: stopwatch

            color: "#00000000"
            width: if(parent.width/parent.height < 1/3){
                       parent.width
                   }
                   else if((parent.width/parent.height >= 1/3 && parent.width/parent.height <= 1) || (parent.width/parent.height > 1 && parent.width/parent.height < 4)){
                       parent.width/2
                   }
                   else {
                       parent.width/4
                   }
            height: if(parent.width/parent.height < 1/3){
                        parent.height/4 - toolbar.height/4
                    }
                    else if((parent.width/parent.height >= 1/3 && parent.width/parent.height <= 1) || (parent.width/parent.height > 1 && parent.width/parent.height < 4)){
                        parent.height/2 - toolbar.height/2
                    }
                    else {
                        parent.height - toolbar.height
                    }
            anchors {
                top: parent.top
                left: parent.left
            }

            Image {
                id: stopwatchImage

                source: "images/stopwatch_b_main.png"
                smooth: true
                width: Math.min(Math.min(parent.width * 8/10, parent.height * 8/10), 200)
                height: width
                anchors.centerIn: parent
                Behavior on scale { NumberAnimation { easing.type: Easing.OutExpo; duration: 500 }
                }

                Rectangle {
                    opacity: .3
                    color: styl.back_color_primary
                    width: parent.width
                    height: width
                    radius: width/2
                    anchors.centerIn: parent
                }

                MouseArea {
                    id: mouse_area2

                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: stopwatchImage.scale = 1.1
                    onExited: stopwatchImage.scale = 1
                    onClicked: {
                        main_file.state = "stopwatchBase"
                    }
                }
            }
        }

        Rectangle {
            id: stopwatchtextes

            color: "#00000000"
            width: stopwatch.width
            height: stopwatch.height
            anchors {
                top: if(parent.width/parent.height < 1/3){
                         stopwatch.bottom
                     }
                     else if(parent.width/parent.height >= 1/3 && parent.width/parent.height <= 1){
                         parent.top
                     }
                     else if(parent.width/parent.height > 1 && parent.width/parent.height < 4){
                         stopwatch.bottom
                     }
                     else {
                         parent.top
                     }
                left: if(parent.width/parent.height < 1/3){
                          parent.left
                      }
                      else if(parent.width/parent.height >= 1/3 && parent.width/parent.height <= 1){
                          stopwatch.right
                      }
                      else if(parent.width/parent.height > 1 && parent.width/parent.height < 4){
                          parent.left
                      }
                      else {
                          stopwatch.right
                      }
            }

            Text {
                id: text1

                color: styl.text_color_primary
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: parent.height/8
                }
                text: qsTr("Stopwatch")
                font {
                    pixelSize: Math.min(parent.width/10, parent.height/10)
                    family: "Ubuntu Light"
                }
            }

            Text {
                id: stopwatchrunning

                color: styl.text_color_primary
                anchors {
                    top: text1.bottom
                    topMargin: height/2
                    //                    horizontalCenter: parent.horizontalCenter
                    left: text1.left
                    leftMargin: text1.width/10
                }
                text: stopwatchtime === "00:00:00.0" ? "" : stopwatchtime  // Display time if Stopwatch is running
                font {
                    pixelSize: Math.min(parent.width/12, parent.height/12)
                    family: "Ubuntu"
                }
            }
        }

        /* ============================ Timer ======================= */
        Rectangle {
            id: timer

            color: "#00000000"
            width: stopwatch.width
            height: stopwatch.height
            anchors {
                top: if(parent.width/parent.height < 1/3){
                         stopwatchtextes.bottom
                     }
                     else if(parent.width/parent.height >= 1/3 && parent.width/parent.height <= 1){
                         stopwatch.bottom
                     }
                     else {
                         parent.top
                     }
                left: if(parent.width/parent.height < 1/3){
                          parent.left
                      }
                      else if(parent.width/parent.height >= 1/3 && parent.width/parent.height <= 1){
                          parent.left
                      }
                      else if(parent.width/parent.height > 1 && parent.width/parent.height < 4){
                          stopwatch.right
                      }
                      else {
                          stopwatchtextes.right
                      }
            }

            Image {
                id: timerImage

                source: "images/timer_b_main.png"
                smooth: true
                width: Math.min(Math.min(parent.width * 8/10, parent.height * 8/10), 200)
                height: width
                anchors.centerIn: parent
                Behavior on scale { NumberAnimation { easing.type: Easing.OutExpo; duration: 500 }
                }

                Rectangle {
                    opacity: .3
                    color: styl.back_color_primary
                    width: parent.width
                    height: width
                    radius: width/2
                    anchors.centerIn: parent
                }

                MouseArea {
                    id: mouse_area4

                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: timerImage.scale = 1.1
                    onExited: timerImage.scale = 1
                    onClicked: {
                        showTimer()
                    }
                }
            }
        }

        Rectangle {
            id: timertextes

            color: "#00000000"
            width: timer.width
            height: timer.height
            anchors {
                top: if(parent.width/parent.height < 1/3){
                         timer.bottom
                     }
                     else if(parent.width/parent.height >= 1/3 && parent.width/parent.height <= 1){
                         stopwatchtextes.bottom
                     }
                     else if(parent.width/parent.height > 1 && parent.width/parent.height < 4){
                         timer.bottom
                     }
                     else {
                         parent.top
                     }
                left: if(parent.width/parent.height < 1/3){
                          parent.left
                      }
                      else if(parent.width/parent.height >= 1/3 && parent.width/parent.height <= 1){
                          timer.right
                      }
                      else if(parent.width/parent.height > 1 && parent.width/parent.height < 4){
                          stopwatchtextes.right
                      }
                      else {
                          timer.right
                      }
            }

            Text {
                id: timerText

                color: styl.text_color_primary
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: parent.height/8
                }
                text: qsTr("Timer")
                font {
                    pixelSize: Math.min(parent.width/10, parent.height/11)
                    family: "Ubuntu Light"
                }
            }

            Text {
                id: timerrunning

                color: styl.text_color_primary
                anchors {
                    top: timerText.bottom
                    topMargin: height/2
                    left: timerText.left
                    leftMargin: -(timerText.width/8)
                }
                text: timertime === "00:00:00" ? "" : timertime  // Display time if timer is running
                font {
                    pixelSize: Math.min(parent.width/12, parent.height/12)
                    family: "Ubuntu"
                }
            }

            Text {
                id: timerstatetext

                color: timerrunning.color
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: timerText.bottom
                    topMargin: height/2
                }
                text: timerstate === "Alarm" ? "Time's Up!" : "" // Alarm if timer stopped
                font: timerrunning.font
            }
        }

        /* ============================ Pomodoro ======================= */

        SettingsMain {
            id: settings_window

            opacity: 0
            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
        }

        ToolbarBottom {
            id: toolbar

            height: 36
            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }

            Rectangle {
                id: settings_button

                color: "#00000000"
                width: 26
                height: 26
                radius: 4
                anchors {
                    left: parent.left
                    leftMargin: 5
                    verticalCenter: parent.verticalCenter
                }

                Image {
                    id: imagesettings

                    source: "images/settings_dark.png"
                    anchors.centerIn: parent
                }

                MouseArea {
                    id: settings_button_ma

                    anchors.fill: parent
                    onClicked: {
                        main_file.state == "" ? main_file.state = "SettingsVisible" : main_file.state = ""
                    }
                }
            }

            Rectangle{
                id: infoButton

                color: "#00000000"
                width: 26
                height: 26
                radius: 4
                anchors {
                    right: parent.right
                    rightMargin: 5
                    verticalCenter: parent.verticalCenter
                }

                Image {
                    id: imageinfo

                    source: "images/about.png"
                    anchors.centerIn: parent
                }

                MouseArea {
                    id: mouse_area3

                    anchors.fill: parent
                    onClicked: {
                        main_file.state !== "AboutVisible" ? main_file.state = "AboutVisible" : main_file.state = ""
                    }
                }
            }

            Rectangle {
                id: helpButton

                color: "#00000000"
                width: 26
                height: 26
                radius: 4
                anchors {
                    right: infoButton.left
                    rightMargin: 5
                    verticalCenter: parent.verticalCenter
                }

                Image {
                    id: imagehelp

                    source: "images/help.png"
                    anchors.centerIn: parent
                }

                MouseArea {
                    id: mouse_area1

                    anchors.fill: parent
                    onClicked: {
                        main_file.state !== "Help" ? main_file.state = "Help" : main_file.state = ""
                    }
                }
            }
        }
    }

    StopwatchWindow {
        id: stopwatchwindow

        width: parent.width
        height: parent.height
        x: parent.width
    }

    TimerWindow {
        id: timerwindow

        width: parent.width
        height: parent.height
        x: parent.width
    }

    AboutInfo {
        id: aboutinfo1

        opacity: 0
        width: parent.width
        height: parent.height - toolbar.height
    }

    Rectangle {
        id: overlay_help

        color: "#44000000"
        z: toolbar.z + 1
        width: main_file.width
        height: main_file.height - toolbar.height
        scale: 0

        MouseArea {
            anchors.fill: parent
            onClicked: main_file.state = ""
        }
    }

    HelpFirst {
        id: helpmain

        scale: 0
        z: overlay_help.z + 1
        anchors.centerIn: overlay_help
    }

    WhatsNew {
        id: whats_new

        scale: 0
        visible: false
        width: parent.width
        height: parent.height
    }

    states: [
        State {
            name: "AboutVisible"
            PropertyChanges {target: aboutinfo1; opacity: 1}
            PropertyChanges {target: stopwatch; opacity: 0}
            PropertyChanges {target: timer; opacity: 0}
            PropertyChanges {target: helpButton; opacity: 0}
            PropertyChanges {target: settings_button; opacity: 0}
            PropertyChanges {target: infoButton; color: styl.toolbar_bottom_button_active_color}
        },
        State {
            name: "stopwatchBase"
            PropertyChanges {target: stopwatchwindow; x: 0}
            PropertyChanges {target: stopwatchwindow; opacity: 1}
            PropertyChanges {target: welcomewindow; x: -parent.width}
        },
        State {
            name: "timerBase"
            PropertyChanges {target: timerwindow; x: 0}
            PropertyChanges {target: timerwindow; opacity: 1}
            PropertyChanges {target: welcomewindow; x: -parent.width}
        },
        State {
            name: "SettingsVisible"
            PropertyChanges {target: settings_button; color: styl.toolbar_bottom_button_active_color}
            PropertyChanges {target: settings_window; opacity: 1}
            PropertyChanges {target: helpButton; visible: false}
            PropertyChanges {target: infoButton; visible: false}
        },
        State {
            name: "Help"
            PropertyChanges {target: overlay_help; scale: 1}
            PropertyChanges {target: helpmain; scale: 1}
            PropertyChanges {target: helpButton; color: styl.toolbar_bottom_button_active_color}
        }

    ]

    transitions:

        Transition {
        ParallelAnimation {
            NumberAnimation {
                targets: [ stopwatchwindow, timerwindow, welcomewindow ]
                property: "x"
                easing.type: Easing.OutExpo
                duration: 500
            }
            NumberAnimation {
                targets: [ aboutinfo1, settings_window, welcomewindow, stopwatchwindow, timerwindow ]
                property: "opacity"
                duration: 100
            }
        }
        ColorAnimation { duration: 100}
    }

}
