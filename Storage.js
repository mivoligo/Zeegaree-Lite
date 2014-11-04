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


function getDatabase(){
    return openDatabaseSync("Zeegaree-lite", "1.0", "zeegaree-lite", 1000000);
}

/*============== CHECKING DB VERSION ===================*/

// Create special table for DB version number
function createDBVersionTable()
{
    var db = getDatabase();
    db.transaction(
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS dbversion' +
                                  '(dbversionvalue REAL)');
                }
                );
}

// Check if DB value exist
function checkIfDBVersionExist(db_version)
{
    var db = getDatabase();
    var result = ""
    db.transaction(
                function(tx) {
                    var rs = tx.executeSql('SELECT * FROM dbversion WHERE dbversionvalue = ?',
                                           [db_version]);
                    if (rs.rows.length > 0 ) {
                        result = "true";
                    }
                    else {
                        result = "false";
                    }
                }
                );
    return result
}

function checkIfDBVersionTableExists()
{
    var db = getDatabase();
    var result = ""
    db.transaction(
                function(tx) {
                    var rs = tx.executeSql('SELECT name FROM sqlite_master WHERE name="dbversion" AND type="table"');
                    if (rs.rows.length > 0 ) {
                        result = "exist";
                    }
                    else {
                        result = "not_exist";
                    }
                }
                );
    return result
}

// Save DB version to DB
function saveDBVersion(db_version)
{
    var db = getDatabase();
    var result = "";
    db.transaction(
                function(tx) {
                    var rs = tx.executeSql('INSERT INTO dbversion VALUES(?)',
                                           [db_version]);
                    if (rs.rowsAffected > 0) {
                        result = "DB version saved as: " + db_version;
                    } else {
                        result = "Error with saving DB version: " + db_version;
                    }
                }
                );
    console.log(result)
}

/*============== SETTINGS ===================*/


// Create settings table for Work&Play
function createSettingsTable()
{
    var db = getDatabase();
    db.transaction(
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS worksettings' +
                                  '(settingname TEXT,' +
                                  'settingvalue TEXT)');
                }
                );
}

// Check if setting exist for Work&Play
function checkIfSettingExist(setting)
{
    var db = getDatabase();
    var result = ""
    db.transaction(
                function(tx) {
                    var rs = tx.executeSql('SELECT * FROM worksettings WHERE settingname = ?',
                                           [setting]);
                    if (rs.rows.length > 0 ) {
                        result = "true";
                    }
                    else {
                        result = "false";
                    }
                }
                );
    return result
}

// Save setting to DB
function saveSetting(setting, value)
{
    var db = getDatabase();
    var result = "";
    db.transaction(
                function(tx) {
                    var rs = tx.executeSql('INSERT INTO worksettings VALUES(?,?)',
                                           [setting, value]);
                    if (rs.rowsAffected > 0) {
                        result = "Setting: " + setting + " saved as: " + value;
                    } else {
                        result = "Error with saving setting: " + setting;
                    }
                }
                );
    console.log(result)
}

// Get setting from DB
function getSetting(setting)
{
    var db = getDatabase();
    var result = "";
    db.transaction(
                function(tx){
                    var rs = tx.executeSql('SELECT settingvalue ' +
                                           'FROM worksettings ' +
                                           'WHERE settingname = ?',
                                           [setting]);
                    if (rs.rows.length > 0) {
                        result = rs.rows.item(0).settingvalue;
                    }
                    else {
                        result = "Unknown setting";
                    }
                }
                );
    return result
}

// Update setting in DB
function updateSettings(setting, value)
{
    var db = getDatabase();
    var result = "";
    db.transaction(
                function(tx) {
                    var rs = tx.executeSql('UPDATE worksettings '+
                                           'SET settingvalue = ?'+
                                           'WHERE settingname = ?',
                                           [value, setting])
                    if (rs.rowsAffected > 0) {
                        result = "Setting: " + setting + " updated to: " + value;
                    } else {
                        result = "Error with updating setting: " + setting;
                    }
                }
                );
    console.log(result)
}

// Get specific settings for Timer
function getSettingTimer()
{
    repeat_alarm_setting.isSelected = checkIfSettingExist("repeat_alarm") == "true" ? getSetting("repeat_alarm") : true
}


/*============== FAVOURITES FOR TIMER ===================*/

// Create favourites table for Timer
function createFavsTable(){
    var db = getDatabase();
    db.transaction(
                function(tx){
                    tx.executeSql('CREATE TABLE IF NOT EXISTS favs' +
                                  '(fname TEXT,' +
                                  'ftime TEXT,' +
                                  'tstamp TEXT)')
                }
                );
}

// Save favourites for Timer
function saveFavs(favname, favtime, favtimestamp){
    var db = getDatabase();
    var result = "";
    db.transaction(
                function(tx) {
                    var rs = tx.executeSql('INSERT INTO favs VALUES(?, ?, ?)',
                                           [favname, favtime, favtimestamp]);
                    if (rs.rowsAffected > 0) {
                        result = "Favourite: " + favname + " saved with time: " + favtime;
                    }
                    else {
                        result = "Error with saving favourite: " + favname;
                    }
                }
                );
    console.log(result);
}

// Update favourites for Timer
function updateFavs(favname, favtime, favtimestamp){
    var db = getDatabase();
    var result = ""
    db.transaction(
                function(tx) {
                    var rs = tx.executeSql('UPDATE favs '+
                                           'SET fname = ?, ftime = ? '+
                                           'WHERE tstamp = ?',
                                           [favname, favtime, favtimestamp]);
                    if (rs.rowsAffected > 0) {
                        result = "Favourite: " + favname + " updated to: " + favtime;
                    }
                    else {
                        result = "Error with updating favourite: " + favname;
                    }
                }
                );
    console.log(result);
}

// Delete favourites for Timer
function deleteFavs(favtimestamp){
    var db = getDatabase();
    var result = ""
    db.transaction(
                function(tx) {
                    var rs = tx.executeSql('DELETE FROM favs WHERE tstamp = ?',[favtimestamp]);
                    if (rs.rowsAffected > 0) {
                        result = "Favourite with timestamp: " + favtimestamp + " deleted";
                    }
                    else {
                        result = "Error with deleting favourite with timestamp: " + favtimestamp;
                    }
                }
                );
    console.log(result);
}

// Get favourites from DB to ListView for Timer
function getFavs(favlistmodel)
{
    var db = getDatabase();

    db.transaction(
                function(tx) {
                    var rs = tx.executeSql('SELECT * FROM favs');
                    var fname = "";
                    var ftime = "";
                    var tstamp = "";
                    for(var i = 0; i < rs.rows.length; i++) {
                        fname = rs.rows.item(i).fname;
                        ftime = rs.rows.item(i).ftime;
                        tstamp = rs.rows.item(i).tstamp;
                        favlistmodel.append({"nameoffav": fname, "timeoffav": ftime, "favtimestamp": tstamp});
                    }
                }
                );
}
