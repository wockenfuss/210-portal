(function(myApp, $, undefined) {
	$(document).ready(function() {
		bind();
	});

	var bind = function() {
		$('.alert, .error, .notice').fadeIn('normal', function() {
			$(this).delay(2500).fadeOut('slow');
		});
	};

})(window.myApp = window.myApp || {}, jQuery);

