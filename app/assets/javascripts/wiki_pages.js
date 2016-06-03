
$(document).ready(function() {
  $("#prev_render_btn").on(
    "click",
    function() {
      var contents = $("#wiki_edit_contents").val();

      $.post(
        "/render_wiki",
        { contents : contents },
        function(result) {
          $("#wiki_prev_contents").html('<div class="ui divider"></div>' + result);
        });
    });
});
