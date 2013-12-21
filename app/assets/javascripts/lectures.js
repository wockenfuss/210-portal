(function(myLecture, $, undefined) {
	$(document).ready(function() {

		if ($('.powerpoint').length > 0) {
			$('.powerpoint').powerpoint();
		}

		$('#lectureNavbar').on('mouseover', function(e) {
			$(this).animate({'opacity': '1'}, 150);
		}).on('mouseleave', function(e) {
			$(this).animate({'opacity': '0'}, 150);
		});

		var $fluidEl = $('.videoWrapper');
		var $videos = $('.videoWrapper iframe');
		$videos.each(function() {
			$(this)
				.data('aspectRatio', this.height / this.width)
				.removeAttr('height')
				.removeAttr('width');
		});

		$(window).resize(function() {
			setVideoSize($fluidEl, $videos);
		});

		setVideoSize($fluidEl, $videos);
	});

	function setVideoSize($fluidEl, $videos) {
		var newWidth = $fluidEl.width();
		$videos.each(function() {
			var $el = $(this);
			$el
				.width(newWidth)
				.height(newWidth * $el.data('aspectRatio'));
		});
	}
	//// $(document).on('scroll', showCommentResponse);
	// };

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