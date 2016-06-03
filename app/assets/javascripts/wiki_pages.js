
$(document).on("ready page:load", function() {
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

  $(".menu .item").tab({ "onLoad" : show_tab });
});
