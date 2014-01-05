(function( $, undefined ) {
	var pp = {
		elements: [],
		screenOffset: -($(window).height() / 5)
	}
	var elements = [];
	var bind = function() {
		$(window).on('scroll', function() {
			var scrollTop = $(window).scrollTop();
			// console.log('scrolltop: ' + scrollTop);
			if ( $(window).width() > 768) {
				$.each(pp.elements, function() {
						this.checkPosition(scrollTop);
					// this.setOpacity(scrollTop);
				});
			}
		});
		$(window).resize(function() {
			// console.log('resizing');
			$.each(pp.elements, function() {
				pp.screenOffset = -($(window).height() / 5);
				this.init();
				// this.setOpacity($(window).scrollTop());
				if ( $(window).width() > 768) {
					this.checkPosition($(window).scrollTop());
				} else {
					this.target.closest('.graphic').css({'position': 'static'})
				}
			});
		});

		window.setTimeout(function() {
			$(window).trigger('resize');
		}, 0);
	};

	var setOpacity = function(scrollTop) {
		// var scrollTop = $(window).scrollTop();
		var position = scrollTop - pp.screenOffset;
		var fadeInPoint = this.inTriggerPosition - position;
		var fadeOutPoint = this.outTriggerPosition - position;
		if ( (fadeInPoint !== null && fadeInPoint > 0) || (fadeOutPoint !== null && fadeOutPoint < 0)  ) {
			$(this.target).stop().hide();
		} else {
			if ( fadeInPoint < 0 ) {
				$(this.target).stop().show();
			} else {
				$(this.target).stop().hide();
			}
		}
	};

	var checkPosition = function(scrollTop) {
		// console.log('checking position');
		// var position = this.target.position().top;
		var containerTop = this.container.position().top + pp.screenOffset;
		var containerEnd = this.container.position().top + (this.container.height() - this.target.height() + pp.screenOffset - 50);
		// console.log('position: ' + position);
		// console.log('offset ' + pp.screenOffset);
		if (scrollTop > containerTop && scrollTop < containerEnd) {
			if (this.target.closest('.graphic').css('position') !== 'fixed') {
				this.target.closest('.graphic').css({'position': 'fixed',
																						'right': '3%',
																					  'top': this.target.position().top - pp.screenOffset});			
			}
		} else if (scrollTop < containerTop) {
			if (this.target.closest('.graphic').css('position') === 'fixed') {
				this.target.closest('.graphic').css({'position': 'absolute',
																						'right': '3%',
																						'top': 0,
																						'bottom': ''});
			}
		} else {
			if (this.target.closest('.graphic').css('position') === 'fixed') {
				this.target.closest('.graphic').css({'position': 'absolute',
																						'right': '3%',
																						'top': '',
																						'bottom': 0});
			}
		}
	};

	var oldinit = function() {
		// console.log(this);
		this.outTriggerPosition = $(this.target.attr('data-trigger-out')).position().top;
		if ( this.target.attr('data-trigger-in') ) {
			this.inTriggerPosition = $(this.target.attr('data-trigger-in')).position().top + 200;
			// console.log("trigger position: " + this.inTriggerPosition);
			// var parentPos = $(this.target.parent()).position().top + 200;

			// console.log("parent: " + parentPos);
		}
	};

	var init = function() {
		// console.log('offset: ' + pp.screenOffset);
		// console.log('initing');
		// console.log(this);
		// console.log('target: ');
		// console.log(this.target);
		this.container = $(this.target).closest('.sectionContainer').parent();
		$(this.target).closest('.sectionContainer').css('min-height', $(this.target).height() + 50);
		// this.begin = this.container.position().top; 
		// this.end = this.container.position().top + this.container.height();
		// console.log('beginning: ' + this.begin);
		// console.log('end: ' + this.end);
	};

	var methods = {
		init: function( options ) {
			// console.log(this);
			$.each(this, function(index) {
				var element = {
					init: init,
					inTriggerPosition: null,
					outTriggerPosition: null,
					checkPosition: checkPosition
					// setOpacity: setOpacity
				};
				element.target = $(this);
				// element.init();
				pp.elements.push(element);
				// element.setOpacity();
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