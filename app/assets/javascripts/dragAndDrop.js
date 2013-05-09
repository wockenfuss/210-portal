/*
jQuery drag-and-drop plugin
`*/



(function( $, undefined ) {
	draggable = {
		group: null,
		target: null
	};

	// var bind = function() {
	// 	draggable.target.on('dropped', function() {
	// 		draggable.callback();
	// 	});
	// };

	var removeDragListeners = function() {
		draggable.group.off('mousedown mouseup');
		draggable.group.removeClass('dragAndDrop');
	};

	var drag = function($target) {
		$target.css('position', 'absolute').css('width', '200px');
		$(document).on('mousemove', function(e) {
			$target.offset({left: e.clientX - $target.width()/2, top: e.clientY + $target.height()/2});
			// $(this).position('left', e.clientX - 50);
			console.log(e.clientX);
			console.log(e.clientY);
		});
		console.log("drag this");
		console.log($target);
	};

	var drop = function($target) {
		$target.css('position', 'static');
		$(document).off('mousemove');
		console.log('drop this');
		console.log($target);
	};

	var methods = {
		init: function( options ) {
			draggable.group = this;

			draggable.group.addClass('dragAndDrop');

			draggable.group.on('mousedown', function(e) {
				draggable.target = $(e.target).closest('li');
				drag(draggable.target);
			}).on('mouseup', function(e) {
				drop(draggable.target);
				draggable.target = null;
			});


		},
		start: function() {

		},
		target: function() {
			return draggable.target;
		},
		remove: removeDragListeners
	};

  $.fn.dragAndDrop = function( option ) {
		if ( methods[option] ) {
      return methods[option].apply( this, Array.prototype.slice.call( arguments, 1 ));
    } else if ( typeof option === 'function' ||  !option ) {
			return methods.init.apply( this, arguments );
    } else {
      $.error( 'Method ' +  option + ' does not exist on jQuery.timer' );
    }
  };
})( jQuery );