(function(myApp, $, undefined) {
	myApp.Questions = function(questionId) {
		var $questions = $('.questionLinks');
		var $target = $('[data-question="' + questionId + '"]');
		var $others = $('.questionLinks').not($target);
		var $form = $('#addQuestionForm');

		var enableLink = function($selector) {
			$selector.parent().removeClass('disabledLinks')
				.unbind('click');
		};

		var disableLink = function($selector) {
			$selector.parent().addClass('disabledLinks')
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
				enableLink($questions);
				$buttons.hide();
			} else {
				disableLink($questions);
				$buttons.css('display', 'inline-block');
			}
		};

		var toggleDrag = function() {
			var $questions = $('#questionContainer li');
			if ( $questions.hasClass('dragAndDrop') ) {
				removeDragListeners();
				$('#questionContainer li').removeClass('dragAndDrop');
			} else {
				addDragListeners();
				$('#questionContainer li').addClass('dragAndDrop');
			}
		};

		var addDragListeners = function() {
			$('#questionContainer li').on('click', function(e) {
				console.log('reorder');
				e.preventDefault();
				e.stopPropagation();
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