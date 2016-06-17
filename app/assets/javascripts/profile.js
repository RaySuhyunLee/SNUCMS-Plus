// Function called when document is loaded
function userDocumentLoad() {
  $("#desc_input").hide();
}

// Function called when description edition start
function descEdit() {
  $(".description").hide();
  $("#desc_input").show();
}

// Function called when description edition cancled
function descCancle() {
  $(".description").show();
  $("#desc_input").hide();
}

// Function called when description edition saved
function descSave() {
  var desc = $("#input_desc").val();
  $.post(
    "profile/update_desc",
    { desc : desc },
    function(result) {
      $("#desc_text").text(result);
  });

  $(".description").show();
  $("#desc_input").hide();
}
