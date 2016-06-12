function ProfessorFinder(searchBox, searchUrl) {
  var isSearchBegun = false;
  var searchSchedule;
  var searchTimeout = 500;

  searchBox.popup({
    inline: true,
    position: 'bottom left',
    popup: '#popup',
    on: 'manual',
    hideOnScroll: false
  });

  searchBox.on('input', function() {
    if ($(this).val().length == 0) {
      $(this).popup('hide');
    } else {
      if ($(this).popup('is hidden')) {
        $(this).popup('show');
      }
      if (!isSearchBegun) {
        $(this).popup('change content', "<div class='ui active inline centered loader'></div>");
        isSearchBegun = true;
      }
      clearTimeout(searchSchedule);
      searchSchedule = setTimeout(() => {
        getProfessor($(this).val());
      }, 500);
    }
  });

  function getProfessor(name) {
    $.get({
      url: searchUrl,
      data: { name: name },
      success: (data) => {
        showProfessorList(JSON.parse(data));
      }
    });
  }

  function showProfessorList(data) {
    isSearchBegun = false;
    var contents;
    if (data.professors.length > 0) {
      contents = data.professors[0].name;
    } else {
      contents = "음슴";
    }
    searchBox.popup('change content', contents);
  }
}
