
var current_tab = "edit-tab";

// 수정 & 미리보기 탭 전환
$(function() {
  var show_tab = function(tab_path) {
    alert(tab_path);
    current_tab = tab_path;

    if (current_tab === "preview-tab") {
      var contents = $("#wiki_edit_contents").val();
      var title = $(".ui.huge.header").html();

      /*
      $.post(
        "/wiki/" + title + "/edit",
        { data : contents },
        function(result) {
          $("#wiki_edit_prev_tab").html(result);
        });
      */
      $("#wiki_edit_prev_tab").html(contents);
    }
  };

  $(".menu .item").tab({ "onLoad" : show_tab });
});
