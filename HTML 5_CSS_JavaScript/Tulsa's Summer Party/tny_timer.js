
"use strict";

/* See figure 9-11 */

/*
   New Perspectives on HTML5 and CSS3, 7th Edition
   Tutorial 9
   Review Assignment

   Event Timer
   Author: Hasan Mohammad
   Date: 06-22-2019   

*/

/* Function to run and display show clock  */

showClock();
setInterval("showClock()", 1000);

/* Store Current Date and time 
  */

function showClock() {
	var thisDay = new Date();
	var localDate = thisDay.toLocaleDateString();
	var localTime = thisDay.toLocaleTimeString();
  
   /* Display Current time and date  */
  
  document.getElementById("currentTime").innerHTML = "<span>" + localDate + "</span><span>" + localTime + "</span>";
	    
 
  /* Call the nextJuly4 = 4th of July at 9:00 pm */
  
    var j4Date = nextJuly4(thisDay);
    j4Date.setHours(21);
  
  /* Creat eand Declare  Variables days, hrs, mins, secs */
  
    var days = (j4Date - thisDay)/(1000*60*60*24);
    var hrs = (days - Math.floor(days))*24;
    var mins = (hrs - Math.floor(hrs))*60;
    var secs = (mins - Math.floor(mins))*60;
    
    /* Display the time left until the next 4th of July */
    document.getElementById('dLeft').textContent = Math.floor(days);
    document.getElementById('hLeft').textContent = Math.floor(hrs);
    document.getElementById('mLeft').textContent = Math.floor(mins);
    document.getElementById('sLeft').textContent = Math.floor(secs);
}
  
function nextJuly4(currentDate) {
   var cYear = currentDate.getFullYear();
   var jDate = new Date("July 4, 2018");
   jDate.setFullYear(cYear);
   if ((jDate - currentDate) < 0) jDate.setFullYear(cYear + 1);
   return jDate;
}
