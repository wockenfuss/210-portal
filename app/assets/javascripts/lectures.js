(function(myLecture, $, undefined) {
	$(document).ready(function() {

		if ($('#modal').length > 0) {
			bind();
		}

		$('#lectureNavbar').on('mouseover', function(e) {
			$(this).animate({'opacity': '1'}, 150);
		}).on('mouseleave', function(e) {
			$(this).animate({'opacity': '0'}, 150);
		});

	});

	var bind = function() {
		$(window).resize(function() {
			// console.log($(window).width());
			// formatQuestions();
		});

		$(document).on('scroll', removeNavbar);
		// formatQuestions();

		$('.powerpoint').powerpoint();

		// $(document).on('scroll', showCommentResponse);
	};

	var formatQuestions = function() {
		$targets = $('.lectureQuestion, .videoContainer');
		$.each($targets, function() {
			var originalWidth = $('.section').width() * .9;
			var offset = $(this).position().left
			var newWidth = $(window).width() - offset;
			$(this).css('width', newWidth);
			$(this).children('.firstColumn').css('width', originalWidth);
		})
	};

	var removeNavbar = function() {
		// var position = $('#section_2').position().top;
		var position = 2200;
		var scroll_top = $(window).scrollTop();
		var screenPosition = scroll_top - position;
		if ( screenPosition > 0 ) {
			$('#lectureNavbar').animate({'opacity': '0'}, 150);
			$(document).off('scroll', removeNavbar);
		}
	};
	// var showCommentResponse = function() {
	// 	var position = $('#comment_response_section_1').position().top;
	// 	var scroll_top = $(window).scrollTop();
	// 	var screenPosition = scroll_top - position;
	// 	if ( screenPosition > -$(window).height()/2 ) {
	// 		$('#comment_response_section_1').animate({'opacity': 1}, 500);
	// 	}
	// };


})(myLecture = window.myLecture || {}, jQuery)