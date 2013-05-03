(function( $ ) {
	var timer = {
		duration: 5, //default time in minutes
		tickInterval: 1000,
		callback: function() {
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
				// this.callback();
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
			if ( Array.prototype.slice.call( arguments, 1 ).length > 0 ) {
				timer.callback = Array.prototype.slice.call( arguments, 1 )[0];
			}
			$.extend(timer, { duration: options });
			timer.target = this;
			timer.millisecondsDuration = timer.duration * 60000;
			bind();
			timer.display(timer.millisecondsDuration);
		},
		start: function() {
			timer.startTime = new Date().getTime();
			timer.display(timer.millisecondsDuration);
			setTimeout(timer.tick, timer.tickInterval);
		}
	};

  $.fn.timer = function( option ) {
		if ( methods[option] ) {
      return methods[option].apply( this, Array.prototype.slice.call( arguments, 1 ));
    } else if ( typeof option === 'number' || ! option ) {
      return methods.init.apply( this, arguments);
    } else {
      $.error( 'Method ' +  option + ' does not exist on jQuery.timer' );
    }
  };
})( jQuery );