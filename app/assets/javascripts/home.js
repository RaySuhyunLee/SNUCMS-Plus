var how_many = 5;

function initTimeline(load_url) {
  timelineContainer = $('#timeline-container');
  /*var listView = new infinity.ListView(
    timelineContainer
  );*/
  count = 0;
  updateScheduled = false;
  url = load_url;

  $(window).on('scroll', function() {
    if(!updateScheduled) {
      append();
    }
  });

  append();
}

function append() {
    updateScheduled = true;
    var data = { offset: count * how_many, how_many: how_many }
    $.get(
      url,
      data,
      function(result) {
        var issues = JSON.parse(result).issues;
        for (var i in issues) {
          var newContent = "<div class='item'>" + issues[i].title + "</div>";
          timelineContainer.append(newContent);
        }
        count += 1;
        updateScheduled = false;

        if (issues.length < how_many) {
          $('#loader').removeClass('active');
        }
      }
    );
  }

  function onscreen($el) {
    var viewportBottom = $(window).scrollTop() + $(window).height();
    return $el.offset().top <= viewportBottom;
  }

