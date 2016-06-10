
// Edit & Preview tab change
function show_tab(tab_path) {
  if (tab_path === "prev_tab") {
    var contents = $("#wiki_edit_contents").val();

    $.post(
      "/wikipage/render",
      { contents : contents },
      function(result) {
        $("#wiki_prev_contents").html(result);
      });
  }
};

// Resolve race condition in editing wiki page
function periodic_worker() {
  var title = $("#edit_title").text();
  var time = $("#edit_time").text();

  $.post(
    "/wikipage/permission",
    {
      title : title,
      time : time
    },
    function(json) {
      if (json.result === "occupied") {
        $("#edit_tab_submit").attr("disabled", true);
        $("#prev_tab_submit").attr("disabled", true);

        alert("문서가 이미 수정되었습니다.");
      }
      else
        setTimeout(periodic_worker, 5000);
    });
};
