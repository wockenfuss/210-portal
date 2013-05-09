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
				// $questions.dragAndDrop('remove');
			} else {
				$questions.bind('click', function(e) {
					e.preventDefault();
					e.stopPropagation();
				});
				$questions.addClass('dragAndDrop');
				$('#sortable').sortable({
					'opacity': 0.7,
					update: function(event, ui) {
						console.log('event: ' + event.target);
						console.log('item: ' + ui.item);
						eventObject = event.target;
						object = ui;
					}
				});
				// $questions.dragAndDrop();
			}
		};

		// var addDragListeners = function($selector) {
		// 	$selector.on('click', function(e) {
		// 		console.log('reorder');
		// 		e.preventDefault();
		// 		e.stopPropagation();
		// 	});
		// };

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