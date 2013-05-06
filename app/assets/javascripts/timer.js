/*
Very simple jQuery countdown timer
Displays a countdown in an HTML element.

Sets the background of the element to red on completion.

Can optionally be initialized with a duration and a function to execute
on completion.

$(element).timer();
$(element).timer(durationInMinutes);
$(element).timer(durationInMinutes, function);
$(element).timer(function);

$(element).timer('start')

*/



(function( $, undefined ) {
	timer = {
		duration: 0.1, //default time in minutes
		tickInterval: 1000, //timer interval in milliseconds
		callback: function() { //default callback executed on timer completion
			alert("Time's up");
		},
		elapsedTime: function() {
			return (new Date().getTime()) - this.startTime;
		},
		tick: function() {
			var millisecondsRemaining = timer.millisecondsDuration - timer.elapsedTime();
			timer.display(millisecondsRemaining);
			if ( millisecondsRemaining <= 0 ) {
				timer.target.trigger('out-of-time');
			} else {
				setTimeout(timer.tick, timer.tickInterval);
			}
		},
		display: function(millisecondsRemaining) {
			timer.target.html(timer.timeFormat(millisecondsRemaining));
		},
		timeFormat: function(milliseconds) {
			if ( milliseconds < 0 ) {
				return "00:00";
			}
			var padded = milliseconds + 999;
			return timer.hours(padded) + timer.minutes(padded) + ":" + timer.seconds(padded);
		},
		hours: function(time) {
			var hours = Math.floor(time/3600000);
			hours = (hours > 0) ? hours + ":" : "";
			return hours;
		},
		minutes: function(time) {
			return timer.zeroPad(Math.floor( time/60000 ) % 60);
		},
		seconds: function(time) {
			return timer.zeroPad(Math.floor( time/1000 ) % 60);
		},
		zeroPad: function(n) {
			if ( n < 10 ) return "0" + n;
			return "" + n;
		}
	};

	var bind = function() {
		timer.target.on('out-of-time', function() {
			$(this).css('background-color', '#f00');
			timer.callback();
		});
	};

	var methods = {
		init: function( options ) {
			if ( arguments.length > 1 ) {
				timer.callback = Array.prototype.slice.call( arguments, 1 )[0];
				$.extend(timer, { duration: options });
			} else if ( typeof arguments[0] === 'function' ) {
				timer.callback = arguments[0];
			} else {
				$.extend(timer, { duration: options });
			}
			timer.target = this;
			timer.millisecondsDuration = timer.duration * 60000;
			bind();
			timer.display(timer.millisecondsDuration);
		},
		start: function() {
			if ( timer.target === undefined ) {
				methods.init.apply( this, arguments );
			}
			timer.startTime = new Date().getTime();
			setTimeout(timer.tick, timer.tickInterval);
		}
	};

  $.fn.timer = function( option ) {
		if ( methods[option] ) {
      return methods[option].apply( this, Array.prototype.slice.call( arguments, 1 ));
    } else if ( typeof option === 'function' || typeof option === 'number' || !option ) {
			return methods.init.apply( this, arguments );
    } else {
      $.error( 'Method ' +  option + ' does not exist on jQuery.timer' );
    }
  };
})( jQuery );