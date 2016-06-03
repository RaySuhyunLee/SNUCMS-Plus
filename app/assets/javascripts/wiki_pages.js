
// 수정 & 미리보기 탭 전환
$(function() {
  function show_tab(tab_path) {
    alert(tab_path);

    if (tab_path === "preview-tab") {
      var contents = $("#wiki_edit_contents").val();
      alert(contents);

      $.post(
        "/render_wiki",
        { contents : contents },
        function(result) {
          $("#wiki_edit_prev_tab").html(result);
        });
    }
  };

  $(".menu .item").tab({ "onLoad" : show_tab });
});
