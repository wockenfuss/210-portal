(function(myApp, $, undefined) {
	myApp.Questions = function(questionId) {
		var $questions = $('.questionLinks');
		var $target = $('[data-question="' + questionId + '"]');
		var $others = $('.questionLinks').not($target);
		var $form = $('#addQuestionForm');

		var enableLink = function($selector) {
			$selector.closest('li').removeClass('disabledLinks')
				.unbind('click');
		};

		var disableLink = function($selector) {
			$selector.closest('li').addClass('disabledLinks')
				.bind('click', function(e) {
					e.preventDefault();
					e.stopPropagation();
			});
		};

		var toggleSelected = function() {
			if ( $form.is(':visible') ) {
				enableLink($others);
				$target.parent().next().hide();
				myApp.Links('#linkbarLinks a').listen();
			} else {
				myApp.Links('#linkbarLinks a').stopListening();
				disableLink($others);
				$target.parent().next().css('display', 'inline-block');
			}
			$form.slideToggle();
		};

		var toggleAll = function() {
			if ( $form.is(':visible') ) {
				enableLink($questions);
			} else {
				disableLink($questions);
			}
		};

		var toggleDelete = function() {
			var $buttons = $('.deleteButton');
			if ( $buttons.is(':visible') ) {
				$questions.unbind('click');
				$buttons.hide();
			} else {
				$questions.bind('click', function(e) {
					e.preventDefault();
					e.stopPropagation();
				});
				$buttons.css('display', 'inline-block');
			}
		};

		var toggleDrag = function() {
			var $questions = $('#questionContainer li');
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
						updateOrder(event, ui);
					}
				});
			}
		};

		var updateNames = function() {
			var re = /Question (\d)/
			var $questions = $('a:contains("Question ")');
			$.each($questions, function(index, value) {
				number = $(value).attr('data-sort');
				// name = $(value).text();
				new_name = $(value).text().replace(re, "Question " + number);
				$(value).text(new_name);
			});
		};

		var updateOrder = function(e, ui) {
			$.each(e.target.children, function(index, value) {
				var question = $(value).find('div a');
				question.attr('data-sort', index + 1);
				var question_id = question.attr('data-question');
				var data = {
					question: {
						sort_number: question.attr('data-sort')
					}
				};
				$.ajax({
					url: '/questions/' + question_id,
					dataType: 'json',
					data: data,
					type: 'put',
					success: updateNames
				});
			});
		};

		var removeDragListeners = function() {
			$('#questionContainer li').off('click');
		};

		return {
			questions: $questions,
			toggle: toggleSelected,
			toggleAll: toggleAll,
			disable: disableLink,
			toggleDelete: toggleDelete,
			toggleDrag: toggleDrag
		};
	};
})(window.myApp = window.myApp || {}, jQuery);