// issue edition js

// Function called when document is loaded
function documentLoad() {
  $("#issue_title_input").hide();
  $(".comment_edit").hide();
  $("#due_input").hide();
}

// Issue title edit
function issueTitleEdit() {
  $("#issue_edit_button").hide();
  $("#issue_title").hide();
  $("#issue_title_input").show();
  $("#due_edit_button").hide();
}

// Issue title edition cancle
function issueTitleCancle() {
  $("#issue_edit_button").show();
  $("#issue_title").show();
  $("#issue_title_input").hide();
  $("#due_edit_button").show();
}

// Issue title save
function issueTitleSave() {
  var contents = $("#issue_title_string").val();
  var path = this.id + "/update_title";

  $.post(
    path,
    { contents : contents },
    function(result) {
      $("#issue_title_text").text(result);
    });
  $("#issue_edit_button").show()
  $("#issue_title").show();
  $("#issue_title_input").hide();
  $("#due_edit_button").show();
}

// Issue due edit
function dueEdit() {
  $("#due_input").show();
}

// Issue due edtion cancle
function dueEditCancle() {
  $("#due_input").hide();
}

// Issue due save
function dueSave() {
  var due = $("#datetimepicker").val();
  var path = this.id + "/update_due";

  $.post(
    path,
    { due : due },
    function(result) {
      if (result == "") {
        $("#issue_due").text("Issue due: none");
      } else {
        $("#issue_due").text("Issue due: " + result);
      }
    });
  $("#due_input").hide()
}

// Comment edit 
function commentEdit() {
  id = this.id;
  id_split1 = id.split("#");
  comment_path = id_split1[1] + "/get_contents";
  id_split2 = (id_split1[0]).split("_");
  idx = id_split2[3];

  $.get(
    comment_path,
    function(result) {
      $("#edit_text_"+idx).text(result); 
    });
  $("#comment_"+idx).hide();
  $("#comment_edit_"+idx).show();
}

// Comment edit save
function commentSave() {
  id = this.id;
  id_split1 = id.split("#");
  comment_path = id_split1[1] + "/update_contents";
  id_split2 = (id_split1[0]).split("_");
  idx = id_split2[2];
  edited_text = $("#edit_text_"+idx).val();

  $.post(comment_path, { contents : edited_text });
  $("#comment_"+idx).show();  
  $("#comment_text_"+idx).load(location.href + " #comment_text_" + idx + ">*","");
  $("#comment_edit_"+idx).hide();
}

// Comment edit cancle
function commentCancle() {
  id = this.id;
  id_split = id.split("_");
  idx = id_split[2];
  $("#comment_"+idx).show();  
  $("#comment_edit_"+idx).hide();
}

// Datetime clear
function datetimeClear() {
  $("#datetime_div").datetimepicker('reset')
}
