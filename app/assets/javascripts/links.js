(function(myApp, $, undefined) {
	$.extend(myApp, {
		Links: function(selector) {
			var $links = $(selector);
			var addListeners = function() {
				$links.removeClass('disabledLinks');
				enableLink($links);
			};

			var toggleOthers = function() {
				var target = arguments[0].target;
				var $others = $links.not(target);
				if ( $others.css('opacity') !== '1' ) {
					enableLink($others);
				} else {
					disableLink($others);
				}
				$others.toggleClass('disabledLinks');
			};

			var disableLink = function($selector) {
				$selector.off('click')
					.bind('click', function(e) {
						e.preventDefault();
						e.stopPropagation();
					});
			};

			var enableLink = function($selector) {
				$selector.unbind('click')
					.on('click', toggleOthers);
			};

			var removeListeners = function() {
				$links.off('click');
				$links.addClass('disabledLinks');
				disableLink($links);
			};

			var enableAll = function() {
				$links.removeClass('disabledLinks');
				enableLink($links);
			};

			return {
				links: $links,
				listen: addListeners,
				stopListening: removeListeners,
				enable: enableAll
			};
		}
	});
})(window.myApp = window.myApp || {}, jQuery);