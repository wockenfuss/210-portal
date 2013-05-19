(function(myLecture, $, undefined) {
	$(document).ready(function() {
		bind();

		$('#lectureNavbar').on('mouseover', function(e) {
			$(e.target).animate({'opacity': '1'}, 150);
		}).on('mouseleave', function(e) {
			$(e.target).animate({'opacity': '0'}, 150);
		});

	});

	var bind = function() {
		var position = $('#section_2').position().top;
		$(document).on('scroll', function() {
			var scroll_top = $(window).scrollTop();
			var screenPosition = scroll_top - position;
			if ( screenPosition > 0 ) {
				$('#lectureNavbar').animate({'opacity': '0'}, 150);
				$(document).off('scroll');
			}
		});

		$('.powerpoint').powerpoint();

	};

})(myLecture = window.myLecture || {}, jQuery)