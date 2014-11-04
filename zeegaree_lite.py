#!/usr/bin/python
# -*- coding: utf-8 -*-



# Copyright 2013-2014 Michał Prędotka

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


from gi.repository import Unity, Notify
from PySide import QtCore, QtGui, QtDeclarative
import subprocess
import os
import datetime




NOTIFICATION_ICON = os.path.join(os.path.dirname(__file__), "./images/z-l_128.png")
TRAY_ICON = os.path.join(os.path.dirname(__file__), "./images/mono_color_32.png")
UNITY_LAUNCHER = Unity.LauncherEntry.get_for_desktop_id("zeegaree-lite.desktop")
HOME = os.path.expanduser("~")
FIRST_FILE = HOME + "/.config/zeegaree-lite/firstrun.txt"

class Notification(QtCore.QObject):
    """ Notification about Timer events
    
    Notification uses Ubuntu Notify and sound played with paplay"""
    @QtCore.Slot(str, str, str)
    
    def somethingFinished(self, subject, body, soundfile):
        timerSound = os.path.join(os.path.dirname(__file__), soundfile)
        Notify.init("Timer finished")
        notification = Notify.Notification.new (subject, body, NOTIFICATION_ICON)
        notification.set_urgency(Notify.Urgency.CRITICAL)
        notification.show()
        subprocess.Popen(["paplay", timerSound])

class Launcher(QtCore.QObject):
    
    """ Stuff specific to Unity Launcher """
    @QtCore.Slot(str)
    def setUrgent(self, value):
        """ Setting urgent state of icon in Unity launcher """
        UNITY_LAUNCHER.set_property("urgent", value) 

    
    @QtCore.Slot(float)
    def getTimerProgress(self, value):
        """ Display timer progress """
        UNITY_LAUNCHER.set_property("progress", value)
        if value > 0:
            UNITY_LAUNCHER.set_property("progress_visible", True)
        else:
            UNITY_LAUNCHER.set_property("progress_visible", False)


class SaveClass(QtGui.QMainWindow):
    """ Save Lap times and/or Split times from Stopwatch """
    @QtCore.Slot(str, str)

    def getSomethingToSave(self, file_title, text_to_write):
        now = datetime.datetime.now()
        file_name = file_title+" "+str(now.strftime("%x %X")+".txt")
        fileName, filtr = QtGui.QFileDialog.getSaveFileName(self,
                "Save "+file_title,
                file_name,
                "Text Files (*.txt);;All Files (*)")

        if fileName:
            laptimefile = open(fileName, "w+")
            laptimefile.write(text_to_write)
            laptimefile.close()



class FirstRun(QtCore.QObject):
    """ Create file on first run """
    
    @QtCore.Slot()
    
    def createTimerFile(self):
        firstfile = open(FIRST_FILE, "w+")
        firstfile.write("Timer_clicked")
        firstfile.close()
        
    
    @QtCore.Slot(result = str)
    
    def checkTimerFile(self):
        if os.path.exists(FIRST_FILE):
            firstfile = open(FIRST_FILE, "r")
            textcheck = firstfile.readline()
            firstfile.close()
            if textcheck == "Timer_clicked":
                return "Timer clicked"
class SystemTrayIcon(QtGui.QSystemTrayIcon):
    
    def __init__(self, icon, parent=None):
        QtGui.QSystemTrayIcon.__init__(self, icon, parent)
        menu = QtGui.QMenu(parent)

        self.setContextMenu(menu)
        self.showMainWindow = QtGui.QAction("Show", self, triggered = self.onShowMainWindow)
        self.showMainWindow.setVisible(False)
        
        self.hideMainWindow =QtGui.QAction("Hide", self)
        self.hideMainWindow.setVisible(True)
        self.hideMainWindow.triggered.connect(self.onHideMainWindow)
        
        self.stopwatchMenuTitle = QtGui.QAction("Stopwatch", self)
        self.stopwatchMenuTitle.setDisabled(True)

        self.stopwatchMenuStart = QtGui.QAction("Start stopwatch", self, triggered = self.onStopwatchStart)
    
        self.stopwatchMenuPause = QtGui.QAction("Pause stopwatch", self, triggered = self.onStopwatchPause)
        self.stopwatchMenuPause.setVisible(False)
        
        self.stopwatchMenuResume = QtGui.QAction("Resume stopwatch", self, triggered = self.onStopwatchStart)
        self.stopwatchMenuResume.setVisible(False)
        
        self.stopwatchMenuLap = QtGui.QAction("Lap", self, triggered = self.onStopwatchLap)
        self.stopwatchMenuLap.setVisible(False)
        
        self.stopwatchMenuSplit = QtGui.QAction("Split", self, triggered = self.onStopwatchSplit)
        self.stopwatchMenuSplit.setVisible(False)
        
        self.stopwatchMenuReset = QtGui.QAction("Reset stopwatch", self, triggered = self.onStopwatchReset)
        self.stopwatchMenuReset.setVisible(False)
        
        self.timerMenuTitle = QtGui.QAction("Timer", self)
        self.timerMenuTitle.setDisabled(True)
        
        self.timerMenuSet = QtGui.QAction("Set timer", self, triggered = self.onTimerSet)
        
        self.timerMenuStop = QtGui.QAction("Stop timer", self, triggered = self.onTimerStop)
        self.timerMenuStop.setVisible(False)
        
        self.timerMenuReset = QtGui.QAction("Reset timer", self, triggered = self.onTimerReset)
        self.timerMenuReset.setVisible(False)
               

       
        menu.addAction(self.showMainWindow)
        menu.addAction(self.hideMainWindow)
    
        menu.addSeparator()
        
        menu.addAction(self.stopwatchMenuTitle)
        menu.addAction(self.stopwatchMenuStart)
        menu.addAction(self.stopwatchMenuPause)
        menu.addAction(self.stopwatchMenuResume)
        menu.addAction(self.stopwatchMenuLap)
        menu.addAction(self.stopwatchMenuSplit)
        menu.addAction(self.stopwatchMenuReset)
        
        menu.addSeparator()
    
        menu.addAction(self.timerMenuTitle)
        menu.addAction(self.timerMenuSet)
        menu.addAction(self.timerMenuStop)
        menu.addAction(self.timerMenuReset)

        menu.addSeparator()
   
        menu.addAction(QtGui.QAction("Quit", self, triggered= app.exit))
    
    def iconActivated(self, reason):
        
        if reason == QtGui.QSystemTrayIcon.Trigger:
            trayIcon.showMainWindow.setVisible(False)
            trayIcon.hideMainWindow.setVisible(True)
            view.show()
            view.activateWindow()
        
    def onShowMainWindow(self):
        
        self.showMainWindow.setVisible(False)
        self.hideMainWindow.setVisible(True)
        view.show()
        view.activateWindow()
    
    def onHideMainWindow(self):
        
        self.hideMainWindow.setVisible(False)
        self.showMainWindow.setVisible(True)
        view.hide()
    
    def onStopwatchStart(self):
        
        self.stopwatchMenuStart.setVisible(False)
        self.stopwatchMenuPause.setVisible(True)
        self.stopwatchMenuLap.setVisible(True)
        self.stopwatchMenuSplit.setVisible(True)
        self.stopwatchMenuReset.setVisible(True)
        rootObject.startStopwatch()
        
    @QtCore.Slot()

    def onStopwatchStartFromQML(self):
        
        trayIcon.stopwatchMenuStart.setVisible(False)
        trayIcon.stopwatchMenuResume.setVisible(False)
        trayIcon.stopwatchMenuPause.setVisible(True)
        trayIcon.stopwatchMenuLap.setVisible(True)
        trayIcon.stopwatchMenuSplit.setVisible(True)
        trayIcon.stopwatchMenuReset.setVisible(True)
        
    
    def onStopwatchPause(self):
        
        self.stopwatchMenuPause.setVisible(False)
        self.stopwatchMenuResume.setVisible(True)
        rootObject.pauseStopwatch()
        
        
    @QtCore.Slot()
    
    def onStopwatchPauseFromQML(self):
        trayIcon.stopwatchMenuPause.setVisible(False)
        trayIcon.stopwatchMenuResume.setVisible(True)
    

    def onStopwatchReset(self):
        
        self.stopwatchMenuStart.setVisible(True)
        self.stopwatchMenuPause.setVisible(False)
        self.stopwatchMenuResume.setVisible(False)
        self.stopwatchMenuLap.setVisible(False)
        self.stopwatchMenuSplit.setVisible(False)
        self.stopwatchMenuReset.setVisible(False)
        rootObject.resetStopwatch()
        
    @QtCore.Slot()
    
    def onStopwatchResetFromQML(self):
        trayIcon.stopwatchMenuStart.setVisible(True)
        trayIcon.stopwatchMenuPause.setVisible(False)
        trayIcon.stopwatchMenuResume.setVisible(False)
        trayIcon.stopwatchMenuLap.setVisible(False)
        trayIcon.stopwatchMenuSplit.setVisible(False)
        trayIcon.stopwatchMenuReset.setVisible(False)
    
    def onStopwatchLap(self):
        rootObject.getLap()
        
    def onStopwatchSplit(self):
        rootObject.getSplit()
        
    def onTimerSet(self):
        self.showMainWindow.setVisible(False)
        self.hideMainWindow.setVisible(True)
        view.show()
        view.activateWindow()       
        view.raise_()
        rootObject.showTimer()
        
    @QtCore.Slot()
    
    def onTimerStartFromQML(self):
        trayIcon.timerMenuSet.setVisible(False)
        trayIcon.timerMenuStop.setVisible(True)
        trayIcon.timerMenuReset.setVisible(True)
    
    @QtCore.Slot()
    
    def onTimerStopFromQML(self):
        trayIcon.timerMenuSet.setVisible(True)
        trayIcon.timerMenuStop.setVisible(False)
        trayIcon.timerMenuReset.setVisible(False)
    
    def onTimerStop(self):
        self.timerMenuSet.setVisible(True)
        self.timerMenuStop.setVisible(False)
        self.timerMenuReset.setVisible(False)
        rootObject.stopTimer()
    
    def onTimerReset(self):
        self.timerMenuSet.setVisible(True)
        self.timerMenuStop.setVisible(False)
        self.timerMenuReset.setVisible(False)
        rootObject.resetTimer()
    
           

if __name__ == '__main__':

    import sys
    
    app = QtGui.QApplication(sys.argv)
    try:
        os.makedirs(HOME + "/.config/zeegaree-lite")
    except OSError:
        pass
    view = QtDeclarative.QDeclarativeView()
    view.setSource(QtCore.QUrl(os.path.join(os.path.dirname(__file__),'main.qml')))
    # Fit root object to be able to resize window
    view.setResizeMode(view.SizeRootObjectToView)
    view.setMinimumSize(QtCore.QSize(510, 400))
    view.setWindowTitle("Zeegaree Lite")
    
    # Get the root object of the user interface. 
    rootObject = view.rootObject()
    
    icon = QtGui.QIcon(TRAY_ICON)
    trayIcon = SystemTrayIcon(icon)
    
    notification = Notification()
    launcher = Launcher()
    somethingtosave = SaveClass()
    firstrun = FirstRun()
    trayicon = SystemTrayIcon(trayIcon)

    context = view.rootContext()
    context.setContextProperty("notification", notification)
    context.setContextProperty("launcher", launcher)
    context.setContextProperty("somethingtosave", somethingtosave)
    context.setContextProperty("firstrun", firstrun)
    context.setContextProperty("trayicon", trayicon)
    

    trayIcon.show()
    trayIcon.activated.connect(trayicon.iconActivated)
    view.show()

    sys.exit(app.exec_()) 
