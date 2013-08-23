(function(myApp, $, undefined) {
	$(document).ready(function() {
		bind();
	});

	var bind = function() {
		$('#flash_alert, #flash_error, #flash_notice').fadeIn('normal', function() {
			$(this).delay(2500).fadeOut('slow');
		});

		$('.dropdown a[href="#"]').on('click', function(e) {
			e.preventDefault();
		});

		$('.dropdown a').on('mouseenter', myApp.dropdown); 

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

		$('.unitHeader').on('click', function(e) {
			$(this).next().slideToggle();
		});

		$('.unitContent').first().show();
		myApp.addDiscussionListeners();
		myApp.addPostListeners();
		// $('.accordionLink').on('click', function(e) {
		// 	var $target = $(e.target);
		// 	var body = $target.next();
		// 	$(body).slideToggle();
		// });


		// $('select.customStyle').customSelect();
	};

	myApp.dropdown = function(e) {
		$trigger = $(e.target);
		$dropdown = $(e.target).parent();
		$menu = $dropdown.find('.dropdownMenu');
		
		$('.dropdown a').off('mouseenter');

		var position = $trigger.position().left + $trigger.width() - $menu.width() + parseInt($trigger.css('margin-right'), 10) - 10;
		$menu.css('left', position);

		$menu.show();

		$dropdown.on('mouseleave', function(e) {
			$dropdown.find('.dropdownMenu').hide();
			$dropdown.off('mouseleave');
			$('.dropdown a').on('mouseenter', myApp.dropdown);
		})
	};


	myApp.toggleDrag = function(target, callback) {
		var $questions = $(target);
		if ( $questions.hasClass('dragAndDrop') ) {
			$questions.unbind('click');
			$questions.removeClass('dragAndDrop');
			$('#sortable').sortable('destroy');
		} else {
			$questions.bind('click', function(e) {
				e.preventDefault();
				e.stopPropagation();
			});
			$questions.addClass('dragAndDrop');
			$('#sortable').sortable({
				update: function(event, ui) {
					callback.apply(null, arguments);
				}
			});
		}
	};

	myApp.multipleChoiceQuestion = function() {
		$('input[name="question[multiple_choice]"]').on('change', function() {
			$('#answersForm').slideToggle();
		});
	};

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

	myApp.updateComponentOrder = function() {
		var $list = $('#componentList').find('a').not('.deleteButton');
		$.each($list, function(index, value) {
			$(value).attr('data-sort', index + 1);
			var component_id = $(value).attr('data-component');
			var data = {
				component: {
					component_index: $(value).attr('data-sort')
				}
			};
			$.ajax({
				url: '/components/' + component_id,
				dataType: 'json',
				type: 'put',
				data: data,
				success: function(result) {
					
				}
			});
		});
	};


	myApp.addDiscussionListeners = function() {
		$('#discussionCollapse').on('click', function(e) {
			$('#discussionAccordion').slideToggle();
		});
	}

	myApp.addPostListeners = function() {
		$('.postHeader').on('click', function(e) {
			$(this).parent().find('.postContent').slideToggle();
		})
	}

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