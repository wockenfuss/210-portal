// (function(myApp, $, undefined) {

// 	$(document).ready(function() {
// 		myApp.timer = TimerFactory();
// 		myApp.timer.init();
// 		// console.log(makeTime(60000));
// 	});


// 	var TimerFactory = function() {
// 		var timer = {
// 			init: function() {
// 				$.ajax({
// 					url: window.location.pathname,
// 					dataType: 'json',
// 					type: 'get',
// 					success: function(result) {
// 						if ( result ) {
// 							$('#timer').html(result.duration.toTime());
// 						}
// 					}
// 				});
// 			}
// 		};
// 		return timer;
// 	};

// 	Number.prototype.toTime = function() {
// 		return makeTime(this * 60000);
// 	};

// 	makeTime = function(milliseconds) {
// 		if ( milliseconds < 0 ) {
// 			return "0:00:00";
// 		}
// 		var tt = milliseconds + 999;
// 		return Math.floor( tt/3600000 ) + ":" +
// 		zeroPad(Math.floor( tt/60000 ) % 60) + ":" +
// 		zeroPad(Math.floor( tt/1000 ) % 60);
// 	};

// 	zeroPad = function(n) {
// 		if ( n < 10 ) return "0" + n;
// 		return "" + n;
// 	};

// 	// function startTimer(milliseconds) {
// 	// 	nextdue = new Date().getTime();
// 	// 	timeleft = milliseconds;
// 	// 	runTimer();
// 	// }



// 	// function runTimer() {
// 	// 	$('#timer').html(makeTime(timeleft));
// 	// 	if (timeleft<=0) {
// 	// 		alert ("Time's up!");
// 	// 	} else {
// 	// 		var timecorr = (new Date().getTime())-nextdue;
// 	// 		if (timecorr>0 && timecorr<3000) {
// 	// 	  	timeleft -= (tick+timecorr);
// 	// 	  	nextdue += tick;
// 	// 	  	if (timeleft<1) setTimeout ("runTimer()",tick+timeleft);
// 	// 	  	else setTimeout("runTimer()",Math.max(1,tick-timecorr));
// 	// 	  }
// 	// 	  else {
// 	// 	  	nextdue=(new Date().getTime())+tick;
// 	// 	  	timeleft-=tick;
// 	// 	  	if (timeleft<1) setTimeout ("runTimer()",tick+timeleft);
// 	// 	  	else setTimeout("runTimer()",tick);
// 	// 	  }
// 	// 	} 
// 	// }

// })(window.myApp || {}, jQuery);
















