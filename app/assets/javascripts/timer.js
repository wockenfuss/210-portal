(function( $ ) {
	var settings = {
		duration: 5,
		tick: 1000
	};

	Number.prototype.toTime = function() {
		return methods.timeFormat(this);
	};

	var methods = {
		init: function( options ) {
			$.extend( settings, options );
			settings.target = this;
			methods.setDuration(this, methods.startTimer);
		},
		setDuration: function($target, callback) {
			$.ajax({
				url: window.location.pathname,
				dataType: 'json',
				type: 'get',
				success: function(result) {
					if ( result.duration ) {
						settings.duration = result.duration;
					}
					callback.call(null, $target);

				}
			});
		},
		startTimer: function($target) {
			settings.startTime = new Date().getTime();
			settings.millisecondsDuration = settings.duration * 60000;
			methods.displayTimer($target, settings.millisecondsDuration);
			setTimeout(methods.tick, settings.tick);
		},
		tick: function() {
			var timePassed = (new Date().getTime()) - settings.startTime;
			var millisecondsRemaining = settings.millisecondsDuration - timePassed;
			methods.displayTimer(settings.target, millisecondsRemaining);
			if ( millisecondsRemaining <= 0 ) {
				alert("Time's up");
			} else {
				setTimeout(methods.tick, settings.tick);
			}
		},
		displayTimer: function($target, millisecondsRemaining) {
			$target.html(millisecondsRemaining.toTime());
		},
		timeFormat: function(milliseconds) {
			if ( milliseconds < 0 ) {
				return "00:00";
			}
			var tt = milliseconds + 999;
			var hours = Math.floor(tt/3600000);
			hours = (hours > 0) ? hours + ":" : "";
			var minutes = methods.zeroPad(Math.floor( tt/60000 ) % 60);
			var seconds = methods.zeroPad(Math.floor( tt/1000 ) % 60);
			return hours + minutes + ":" + seconds;
		},
		zeroPad : function(n) {
			if ( n < 10 ) return "0" + n;
			return "" + n;
		}

	};

  $.fn.timer = function( method ) {
		if ( typeof method === 'number' || ! method ) {
      return methods.init.apply( this, [{duration: method}]);
    } else {
      $.error( 'Method ' +  method + ' does not exist on jQuery.timer' );
    }
  };
})( jQuery );