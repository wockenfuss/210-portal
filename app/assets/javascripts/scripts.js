(function(myApp, $, undefined) {
	$(document).ready(function() {
		bind();
	});

	var bind = function() {
		$('#flash_alert, #flash_error, #flash_notice').fadeIn('normal', function() {
			$(this).delay(2500).fadeOut('slow');
		});
		$('#dropdownTrigger').on('click', function(e){
			$('#dropdown').slideToggle('normal');
		});
	};

})(window.myApp = window.myApp || {}, jQuery);

