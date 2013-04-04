$(document).ready(function() {
	(function() {
		$('.alert, .error, .notice').fadeIn('normal', function() {
			$(this).delay(2500).fadeOut('slow');
		});
	})();
});
