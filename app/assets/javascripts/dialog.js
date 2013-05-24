$(function() {
    var content = $('#lecture_question_content'),
      index = $('#lecture_question_order_index'),
      lecture_id = $('#lecture_question_lecture_id');
      // allFields = $( [] ).add( name ),
      tips = $( ".validateTips" );
 
    // function updateTips( t ) {
    //   tips
    //     .text( t )
    //     .addClass( "ui-state-highlight" );
    //   setTimeout(function() {
    //     tips.removeClass( "ui-state-highlight", 1500 );
    //   }, 500 );
    // }
 
    $( "#dialog-form" ).dialog({
      draggable: false,
      closeText: 'X',
      autoOpen: false,
      height: 500,
      width: 700,
      modal: true,
      position: { 
        my: "center", at: "center", of: window
        // using: function() {
        //   $(this).css('margin-top', $(window).height()/2);
        // }
      },
      buttons: {
        "Create Question": function() {
          var that = this;
          // allFields.removeClass( "ui-state-error" );
          var data = {
            lecture_id: lecture_id.val(),
            lecture_question: {
              content: content.val(),
              order_index: index.val()
            }
          };
          $.ajax({
            dataType: 'script',
            type: 'post',
            url: '/lectures/' + lecture_id.val() + '/lecture_questions',
            data: data,
            success: function(e) {
              console.log('close');
            }
          });

        },
        Cancel: function() {
          $( this ).dialog( "close" );
        }
      },
      close: function() {
        // allFields.val( "" ).removeClass( "ui-state-error" );
      }
    });
 
    $( "#add_question_button" )
      .button()
      .click(function() {
        $( "#dialog-form" ).dialog( "open" );
      });
  });