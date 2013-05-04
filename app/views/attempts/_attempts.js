$(document).ready(function() {
	$(window).on('beforeunload', function(e) {
		var message = "If you leave this page, you will not be able to return to the quiz.";
		e = e || window.event;
		if (e) {
			e.returnValue = message;
		}
		return message;
	});

	$('form').on('submit', function() {
		$(window).off('beforeunload');
	});

	$(window).on('unload', function() {
		$.ajax({
			type: "POST",
			url: "/users/update",
			async: false,
			dataType: 'json'
		});
	});
});