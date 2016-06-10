// issue edition
$(document).on('ready page:load', function() {
  $("#issue_title_input").hide();
  $(".comment_edit").hide();

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

  $(".edit_button").click(function(){
    id = this.id;
    id_split = id.split("_");
    idx = id_split[3];
    $("#comment_"+idx).hide();
    $("#comment_edit_"+idx).show();
    var content = $("#comment_text_"+idx).text();
    $("#edit_text_"+idx).text(content);
  });

  $(".edit_save_button").click(function(){
    id = this.id;
    id_split = id.split("_");
    idx = id_split[2];
  });

  $(".edit_cancle_button").click(function(){
    id = this.id;
    id_split = id.split("_");
    idx = id_split[2];
    $("#comment_"+idx).show();
    $("#comment_edit_"+idx).hide();
  });

});
