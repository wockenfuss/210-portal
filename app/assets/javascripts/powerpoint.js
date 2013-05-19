(function( $, undefined ) {
	var pp = {
		elements: [],
		screenOffset: -($(window).height() / 2)
	}
	var elements = [];
	var bind = function() {
		$(window).on('scroll', function() {
			var scrollTop = $(window).scrollTop();
			$.each(pp.elements, function() {
				// if ( triggerOut > -100 && triggerOut < 300 ) {
				this.setOpacity();
				// }
			});
		});
		$(window).resize(function() {
			$.each(pp.elements, function() {
				this.init();
			});
		});
	};

	var setOpacity = function() {
		var scrollTop = $(window).scrollTop();
		var position = scrollTop - pp.screenOffset;
		// var opacity;
		var fadeInPoint = this.inTriggerPosition - position;
		var fadeOutPoint = this.outTriggerPosition - position;
		if ( (fadeInPoint !== null && fadeInPoint > 0) || (fadeOutPoint !== null && fadeOutPoint < 0)  ) {
			// $(this.target).stop().fadeOut();
			opacity = 0;
		} else {
			if ( fadeInPoint < -200 ) {
				// $(this.target).stop().fadeOut();
				opacity = fadeOutPoint/200;
			} else {
				// $(this.target).stop().fadeIn();
				opacity = fadeInPoint/-200;
			}
		}
		$(this.target).css('opacity', opacity);
	};

	var init = function() {
		this.outTriggerPosition = $(this.target.attr('data-trigger-out')).position().top;
		if ( this.target.attr('data-trigger-in') ) {
			this.inTriggerPosition = $(this.target.attr('data-trigger-in')).position().top + 200;					
		}
	};

	var methods = {
		init: function( options ) {
			$.each(this, function(index) {
				var element = {
					init: init,
					inTriggerPosition: null,
					outTriggerPosition: null,
					setOpacity: setOpacity
				};
				element.target = $(this);
				element.init();
				pp.elements.push(element);
				element.setOpacity();
			});
			bind();
		}, 
		stop: function() {

		}
	};

  $.fn.powerpoint = function( option ) {
		if ( methods[option] ) {
      return methods[option].apply( this, Array.prototype.slice.call( arguments, 1 ));
    } else if ( typeof option === 'function' || !option ) {
			return methods.init.apply( this, arguments );
    } else {
      $.error( 'Method ' +  option + ' does not exist on jQuery.powerpoint' );
    }
  };

})(jQuery)