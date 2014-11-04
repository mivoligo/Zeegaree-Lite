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

// Functions related to time counting

// Convert miliseconds to days, hours, minutes
function milisecToDaysHoursMinutes(milisec)
{
    var d, m, h, s
    s = Math.floor(milisec / 1000);
    m = Math.floor(s / 60);
    s = s % 60;
    h = Math.floor(m / 60);
    m = m % 60;
    d = Math.floor(h / 24);
    h = h % 24;

    return d !== 0 ? d +"d " + h + "h " + m +"m" : h + "h " + m +"m"
}

// Convert miliseconds to hours, minutes, seconds
function milisecToHoursMinutes(difference)
{
    var hoursDifference = ("0" + Math.floor(difference/1000/60/60)).slice(-2);
    difference -= hoursDifference*1000*60*60
    var minutesDifference = ("0" + Math.floor(difference/1000/60)).slice(-2);
    difference -= minutesDifference*1000*60
    var secondsDifference = ("0" + Math.floor(difference/1000)).slice(-2);
    return  hoursDifference + ':' + minutesDifference + ':' + secondsDifference
}

// display hours or minutes or seconds text in timer
function unitsdisplay(units)
{
    if (units > 59){
        units = (units % 60) - 60
    }
    if (units < 0){
        units = (units % 60) + 60
    }
    if (units === 60){
        units = 0
    }

    return ("0"+units).slice(-2)
}
// Count up Stopwatch
function stopwatchCountUp(h1, h2, m1, m2, s1, s2, ts)
{
    if (ts === 9){
        ts = 0;
        s2 += 1
        if (s2 > 9){
            s2 = 0;
            s1 += 1;
            if (s1 > 5){
                s1 = 0;
                m2 += 1;
                if (m2 > 9){
                    m2 = 0;
                    m1 += 1;
                    if (m1 > 5){
                        m1 = 0;
                        h2 += 1
                        if (h2 > 9){
                            h2 = 0;
                            h1 += 1;
                        }
                    }
                }
            }
        }
    }
    else{
        ts += 1;
    }
    return "" + h1 + h2 + ":" + m1 + m2 + ":" +s1 + s2 + "." + ts
}

