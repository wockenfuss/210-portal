(function(myApp, $, undefined) {
	$(document).ready(function() {
		bind();
	});

	var bind = function() {
		$('#flash_alert, #flash_error, #flash_notice').fadeIn('normal', function() {
			$(this).delay(2500).fadeOut('slow');
		});
		$('#dropdownTrigger, #managerDropdownTrigger').on('click', function(e){
			var $trigger = $(this);
			var $dropdown = $trigger.next();
			if ( !$dropdown.is(':visible') ) {
				$('.dropdown:visible').slideToggle('fast');
				var position = $trigger.position().left + $trigger.width() - $dropdown.width() + parseInt($trigger.css('margin-right'), 10) - 10;
				$dropdown.css('left', position);
			}
			$dropdown.slideToggle('fast');
		});

    $( ".datepicker" ).datepicker();

	};

})(window.myApp = window.myApp || {}, jQuery);

