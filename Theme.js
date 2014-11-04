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

// Set Day theme
function setDayTheme()
{
    styl.text_color_primary = "#3d3d3d"
    styl.text_color_secondary = "#5d5d5d"
    styl.text_color_high = "#29C06E"
    styl.back_color_primary = "#dddddd"
    styl.toolbar_bottom_color = "#ededed"
    styl.toolbar_bottom_button_active_color = "#cdcdcd"
    styl.panel_back_color = "#cdcdcd"
    styl.info_text_color = "#3498db"
    styl.tooltip_back_color = "#5d5d5d"
    styl.tooltip_text_color = "#ededed"
    styl.dialog_back_color = "#d4d4d4"
    styl.text_entry_back_color = "#ffffff"
    styl.text_entry_text_color = "#3d3d3d"
    styl.calendar_day_color = "#d4d4d4"
    styl.calendar_day_active_color = "#e8e8e8"
    styl.task_note_text_color = "#3d3d3d"
    styl.small_menu_button_color = "#5d5d5d"
    styl.small_menu_button_active_color = "#3d3d3d"
    styl.button_text_color = "#3d3d3d"
    styl.button_text_color_active = "#ffffff"
    styl.button_back_color = "#9a9a9a"
    styl.button_back_color_ok = "#2ecc71"
    styl.button_back_color_notok = "#e74c3c"
    styl.close_button_color = "#5d5d5d"
    styl.close_button_active_color = "#3d3d3d"
    styl.edit_icon = "images/edit_gray.png"
    styl.eye_icon = "images/eye_3d3d3d.png"
    styl.list_icon = "images/list_3d3d3d.png"
    styl.arrow_right_icon = "images/arrow_right_3d3d3d.png"
    theme_setting.text = day_theme.text
    day_theme.isSelected = true
}

// Set night theme
function setNightTheme()
{
    styl.text_color_primary = "#eeeeee"
    styl.text_color_secondary = "#989898"
    styl.text_color_high = "#29C06E"
    styl.back_color_primary = "#4c4c4c"
    styl.toolbar_bottom_color = "#898989"
    styl.toolbar_bottom_button_active_color = "#eeeeee"
    styl.panel_back_color = "#222222"
    styl.info_text_color = "#3498db"
    styl.tooltip_back_color = "#eeeeee"
    styl.tooltip_text_color = "#222222"
    styl.dialog_back_color = "#333333"
    styl.text_entry_back_color = "#eeeeee"
    styl.text_entry_text_color = "#222222"
    styl.calendar_day_color = "#333333"
    styl.calendar_day_active_color = "#474747"
    styl.task_note_text_color = "#f1c40f"
    styl.small_menu_button_color = "#989898"
    styl.small_menu_button_active_color = "#eeeeee"
    styl.button_text_color = "#3c3c3c"
    styl.button_text_color_active = "#fff"
    styl.button_back_color = "#9a9a9a"
    styl.button_back_color_accent = "#fff"
    styl.button_back_color_ok = "#2ecc71"
    styl.button_back_color_notok = "#e74c3c"
    styl.close_button_color = "#222222"
    styl.close_button_active_color = "#eeeeee"
    styl.edit_icon = "images/edit_white.png"
    styl.eye_icon = "images/eye_eee.png"
    styl.list_icon = "images/list_eee.png"
    styl.arrow_right_icon = "images/arrow_right_eee.png"
    theme_setting.text = night_theme.text
    night_theme.isSelected = true
}


