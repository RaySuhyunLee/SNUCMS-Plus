// issue edition
$(document).on('ready page:load', function() {
  $("#issue_title_input").hide();

  $("#issue_edit_button").click(function(){
    $("#issue_path_var").hide();
    $("#issue_delete_button").hide();
    $("#issue_edit_button").hide()
    $("#issue_title").hide();
    $("#issue_title_input").show();
    $("#edit_divider").hide();
  });

  $("#issue_title_cancle_button").click(function(){
    $("#issue_delete_button").show();
    $("#issue_edit_button").show()
    $("#issue_title").show();
    $("#issue_title_input").hide();
    $("#edit_divider").show();
  });

  $("#issue_title_save_button").click(function(){
    var contents = $("#issue_title_string").val();
    var path = $("#issue_path_var").text();
    $.post(
      path,
      { contents : contents },
      function(result) {
        $("#issue_title_text").text(result);
      });
    $("#issue_delete_button").show();
    $("#issue_edit_button").show()
    $("#issue_title").show();
    $("#issue_title_input").hide();
    $("#edit_divider").show();
  });
});
