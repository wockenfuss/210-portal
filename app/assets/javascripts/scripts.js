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
    $('#timer').timer();
	};

	myApp.multipleChoiceQuestion = function() {
		$('input[name="question[multiple_choice]"]').on('change', function() {
			$('#answersForm').slideToggle();
		});
	};

	myApp.disableLinksConditionally = function($condition, $linkSelector) {
		if ( $condition.is(':visible') ) {
			myApp.enableLink($linkSelector);
		} else {
			myApp.disableLink($linkSelector);
		}
	};

	myApp.disableLink = function($linkSelector) {
			$linkSelector.parent().addClass('disabledLinks')
				.bind('click', function(e) {
					e.preventDefault();
					e.stopPropagation();
			});
	};

	myApp.enableLink = function($linkSelector) {
		$linkSelector.parent().removeClass('disabledLinks')
				.unbind('click');
	};

	myApp.clearForm = function($selector) {
		$selector.find("input[type=text], textarea").val("");
		$('input[name="question[correct_answer]"]').prop('checked', false);
	};

	myApp.toggleQuestionLinksAndForms = function() {
		if ( $form.is(':visible') ) {
			myApp.enableLink($nonselectedLinks);
			$form.slideToggle();
			$selectedLink.parent().next().hide();
		} else {
			myApp.disableLink($nonselectedLinks);
			$form.slideToggle();
			$selectedLink.parent().next().css('display', 'inline-block');

			myApp.toggleAnswersForm();
		}
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