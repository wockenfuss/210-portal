(function(myLecture, $, undefined) {
	$(document).ready(function() {

		if ($('#section_2').length > 0) {
			bind();
		}

		$('#lectureNavbar').on('mouseover', function(e) {
			$(e.target).animate({'opacity': '1'}, 150);
		}).on('mouseleave', function(e) {
			$(e.target).animate({'opacity': '0'}, 150);
		});

	});

	var bind = function() {
		$(window).resize(function() {
			formatQuestions();
		});

		$(document).on('scroll', removeNavbar);

		$('.powerpoint').powerpoint();

		$(document).on('scroll', showCommentResponse);

		formatQuestions();
	};

	var formatQuestions = function() {
		$questions = $('.lectureQuestion');
		// console.log($questions);
		$.each($questions, function() {
			var originalWidth = $('.section').width() * .9;
			var offset = $(this).position().left
			var newWidth = $(window).width() - offset;
			$(this).css('width', newWidth);
			$(this).children('.firstColumn').css('width', originalWidth);
			var columnTwoOffset = $(this).children('.secondColumn').position().left;
			$(this).children('.secondColumn').css('width', ($(window).width() - originalWidth) * .74 )
			// console.log($(this).height());
																			.children('.commentDisplay').css('height', $(this).height());
			// console.log($(this));
		})
	};

	var removeNavbar = function() {
		var position = $('#section_2').position().top;
		var scroll_top = $(window).scrollTop();
		var screenPosition = scroll_top - position;
		if ( screenPosition > 0 ) {
			$('#lectureNavbar').animate({'opacity': '0'}, 150);
			$(document).off('scroll', removeNavbar);
		}
	};
	var showCommentResponse = function() {
		var position = $('#comment_response_section_1').position().top;
		var scroll_top = $(window).scrollTop();
		var screenPosition = scroll_top - position;
		if ( screenPosition > -$(window).height()/2 ) {
			$('#comment_response_section_1').animate({'opacity': 1}, 500);
		}
	};

})(myLecture = window.myLecture || {}, jQuery)