
// Edit & Preview tab change
function show_tab(tab_path) {
  if (tab_path === "prev_tab") {
    var contents = $("#wiki_edit_contents").val();

    $.post(
      "/render_wiki",
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
    "/edit_permission_wiki",
    {
      title : title,
      time : time
    },
    function(json) {
      if (json.result === "occupied") {
        $("#edit_tab_submit").attr("disabled", true);
        $("#prev_tab_submit").attr("disabled", true);

        // TODO: 수정 해야해요
        alert("서버의 10만볼트! 효과는 뛰어났다!");
      }
      else
        setTimeout(periodic_worker, 5000);
    });
};

$(document).on("ready page:load", function() {
});
