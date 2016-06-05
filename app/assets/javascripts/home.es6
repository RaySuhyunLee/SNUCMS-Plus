var how_many = 5;

class Timeline {
  constructor (containerId, loadUrl) {
    this.timelineContainer = $(containerId);
    this.url = loadUrl;

    this.init();
  }
 
  init() {
    /*var listView = new infinity.ListView(
      timelineContainer
    );*/
    this.count = 0;
    this.updateScheduled = false;
    
    $(window).on('scroll', () => {
      if(!this.updateScheduled) {
        this.append();
      }
    });

    this.append();
  }

  append() {
    this.updateScheduled = true;
    var data = { offset: this.count * how_many, how_many: how_many }
    $.get(
      this.url,
      data,
      (result) => {
        var issues = JSON.parse(result).issues;
        for (var i in issues) {
          var newContent = "<div class='item'>" + issues[i].title + "</div>";
          this.timelineContainer.append(newContent);
        }
        this.count += 1;
        this.updateScheduled = false;

        if (issues.length < how_many) {
          $('#loader').removeClass('active');
        }
      }
    );
  }
 
  onscreen($el) {
    var viewportBottom = $(window).scrollTop() + $(window).height();
    return $el.offset().top <= viewportBottom;
  }
}
