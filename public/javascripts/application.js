function _ajax_request(url, data, callback, type, method) {
    if (jQuery.isFunction(data)) {
        callback = data;
        data = {};
    }
    return jQuery.ajax({
        type: method,
        url: url,
        data: data,
        success: callback,
        dataType: type
        });
}

jQuery.extend({
    put: function(url, data, callback, type) {
        return _ajax_request(url, data, callback, type, 'PUT');
    },
    delete_: function(url, data, callback, type) {
        return _ajax_request(url, data, callback, type, 'DELETE');
    }
});

//function to get new time for given challenge
function update_index_timeleft(){
    
    
        //traverse and update the challenges    
        $('.challenge').each(function(){
        
          var id = $(this).attr("id");
          var the_div = $(this)
          $.get(("/challenges/"+id+"/timeleft"), function(data){

            the_div.html('<h1 class="noice">'+data+'</h1>');
            
          });

        });
        
        

}

$(function() {

  //this updates the challenges in the challenge index path
  setInterval(function(){
    /* Some long block of code... */
    update_index_timeleft();
    //alert('tis time')
  }, 60000); 
   
  //widget
  
  
  //sets first field on focus...nice function!    
$("input:text:first:visible").focus();
  
  //vote with ajax
  $(".voter").change(function () {
      
      var score = $(this).val();
      var cont_id = $(this).attr("id")
       
        $.put(
            //url
            ("/contributions/"+cont_id+"/vote/"), 
            //data
            {votes: score},
            //callback (function to call when success)
            function(data){
              data;
            },
            //callback type script, json, text
            "script"
            );
        
      });

  
  //toggles the comment field on off
  $(".comment_button").click(function () {
      var comment_id = $(this).attr("id");
      $("#comment_div_"+comment_id).toggle();
      //$("#comment_div").toggle();
    });

  
  //articles can be edited and removed when mouse over

  
  $('.article').hover(function(){
        //when mouse is over an article    
        
        $(this).animate({opacity: 0.4});

        var article_id = $(this).attr("id");
        var edit_url = $("#menu_"+article_id);
        $(this).prepend('<div id="tmp_menu_'+article_id+'">'+ edit_url.html()+'</div>');
    },
    
    function(){
        //when mouse moves away from article
        $(this).animate({opacity: 1});
        var article_id = $(this).attr("id");
        $("#tmp_menu_"+article_id).remove();
    
    })
   
   $('#personal_signature').hover(function(){
        //when mouse is over an article    
        $(this).animate({opacity: 0.4});
        var edit_url = $("#account_menu");
        $(this).prepend('<div id="tmp_menu_tt">'+ edit_url.html()+'</div>');
    },
    
    function(){
        //when mouse moves away from article
        $(this).animate({opacity: 1});
        var article_id = $(this).attr("id");
        $("#tmp_menu_tt").remove();
    })
   
   $('#account_signature').hover(function(){
        //when mouse is over an article    
        $(this).animate({opacity: 0.4});
        var edit_url = $("#account_menu");
        $(this).prepend('<div id="tmp_menu_pp">'+ edit_url.html()+'</div>');
    },
    
    function(){
        //when mouse moves away from article
        $(this).animate({opacity: 1});
        var article_id = $(this).attr("id");
        $("#tmp_menu_pp").remove();
    })
  
  
  
$('#logo_on_top').change(function () {
    
    if ($(this).attr("checked")) {
        alert('cehcked');
        //do stuff if the checkbox is checked
    
    } else {
    
        alert('not checked'); 
        //do stuff if the checkbox isn't checked
    }
});


});
