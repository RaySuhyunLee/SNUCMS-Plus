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
    this.issueContainer = $("<div></div>")
        .addClass("ui relaxed devided list");
    this.loader = $("<div></div>")
        .addClass("ui inline text loader")
        .append('긁어오는 중');
    this.timelineContainer.append(this.issueContainer);
    this.timelineContainer.append(this.loader);
    
    $(window).on('scroll', () => {
      if(!this.updateScheduled && this.isLoaderOnScreen()) {
        this.loader.addClass("active");
        setTimeout(() => {this.append();}, 1000);
      }
    });

    this.append();
  }

  append() {
    this.updateScheduled = true;
    var data = { offset: this.count, how_many: how_many }
    $.get(
      this.url,
      data,
      (result) => {
        var issues = JSON.parse(result).issues;
        for (var i in issues) {
          var issue = issues[i];
          var created_at = new Date(issue.created_at);
          var elapsed = Date.now() - created_at.getTime();
          var elapsedHour = Math.floor(elapsed / (60 * 60 * 1000));
          var newItem = $("<div class='item'></div>");
          var content = $("<div class='content'></div>");
          var course = $("<a class='header'>" + issue.parent_title + "</a>");
          course.attr('href', issue.parent_url);
          content.append(course);
          content.append(issue.title + "<br>");
          content.append(elapsedHour + "시간 전");
          newItem.append(content);
          this.issueContainer.append(newItem);
        }
          this.count += issues.length;

        this.updateScheduled = false;
        this.loader.removeClass('active');
      }
    );
  }
 
  isLoaderOnScreen() {
    var viewportBottom = $(window).scrollTop() + $(window).height();
    return this.loader.offset().top <= viewportBottom;
  }
}
