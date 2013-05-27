(function(myApp, $, undefined) {
	$(document).ready(function() {
		bind();
	});

	var bind = function() {
		$('#flash_alert, #flash_error, #flash_notice').fadeIn('normal', function() {
			$(this).delay(2500).fadeOut('slow');
		});
		$('#dropdownTrigger, #managerDropdownTrigger').on('mouseover', function(e){
			var $trigger = $(this);
			var $dropdown = $trigger.next();
			if ( !$dropdown.is(':visible') ) {
				$('.dropdown:visible').slideToggle('fast');
				var position = $trigger.position().left + $trigger.width() - $dropdown.width() + parseInt($trigger.css('margin-right'), 10) - 10;
				$dropdown.css('left', position);
				$dropdown.on('mouseleave', function() {
					$dropdown.slideToggle('fast');
					$dropdown.off('mouseleave');
				});
			}
			$dropdown.slideToggle('fast');
		});

    $( ".datepicker" ).datepicker();

    if ( $('#timer').length > 0 ) {
			$.ajax({
				url: window.location.pathname,
				dataType: 'json',
				type: 'get',
				success: function(result) {
					if ( result.duration ) {
						$('#timer').timer('start', result.duration);
					}
				}
			});
		}
		
		myApp.Links('#linkbarLinks a').listen();

	};

	myApp.multipleChoiceQuestion = function() {
		$('input[name="question[multiple_choice]"]').on('change', function() {
			$('#answersForm').slideToggle();
		});
	};

	// myApp.disableLinksConditionally = function($condition, $linkSelector) {
	// 	if ( $condition.is(':visible') ) {
	// 		myApp.enableLink($linkSelector);
	// 	} else {
	// 		myApp.disableLink($linkSelector);
	// 	}
	// };

	// myApp.disableLink = function($linkSelector) {
	// 		$linkSelector.parent().addClass('disabledLinks')
	// 			.bind('click', function(e) {
	// 				e.preventDefault();
	// 				e.stopPropagation();
	// 		});
	// };

	myApp.enableLink = function($linkSelector) {
		$linkSelector.removeClass('disabledLinks')
				.unbind('click');
	};

	myApp.clearForm = function($selector) {
		$selector.find("input[type=text], textarea").val("");
		$('input[name="question[correct_answer]"]').prop('checked', false);
	};

	myApp.toggleAnswersForm = function() {
		if ( $('#question_multiple_choice_true').prop('checked') === true ) {
			$('#answersForm').slideToggle();
		}
	};

	// myApp.removeUserRole = function() {
	// 	var remote = $.ajax({
	// 		type: "POST",
	// 		url: "/users/update",
	// 		async: false,
	// 		dataType: 'json'
	// 	}).responseText;
	// 	return remote;
	// };

})(window.myApp = window.myApp || {}, jQuery);