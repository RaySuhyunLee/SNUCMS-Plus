
var IssueList = React.createClass({
  render: function() {
    var issueFeeds = this.props.data.map( function(issue) {
      return (
        <div className="event" key={issue.id}>
          <div className="content">
            <div className="summary" >
              <a href={issue.parent_url}> {issue.parent_title} </a>
              <div className="date">
                {issue.created_at}
              </div>
            </div>
            <div className="extra text">
              <a href={issue.issue_url}> {issue.title} </a>
            </div>
          </div>
        </div>
      );
    });
    return (
      <div className="ui feed">
        {issueFeeds}
      </div>
    );
  }
}); 

var IssueContainer = React.createClass({
  count: 0,
  issueList: [],
  loadMoreIssues: function(courses) {
    var course_ids = []
    courses.map(function(course) {
      if (course.checked) course_ids.push(course.id);
    });
    $.get({
      url: this.props.url,
      data: { course_ids: course_ids, offset: this.count, how_many: this.props.how_many },
      success: (result) => {
        var issues = JSON.parse(result).issues;
        this.issueList = this.issueList.concat(issues);
        this.count += issues.length;
        this.setState({data: this.issueList});
        this.props.update_done(issues.length);
      }
    });
  },
  refreshIssues: function(courses) {
    var course_ids = []
    courses.map(function(course) {
      if (course.checked) course_ids.push(course.id);
    });
    $.get({
      url: this.props.url,
      data: { course_ids: course_ids, offset: this.count, how_many: this.props.how_many },
      success: (result) => {
        var issues = JSON.parse(result).issues;
        this.issueList = issues;
        this.setState({data: this.issueList});
        this.props.update_done(issues.length);
      }
    });
  },
  getInitialState: function() {
    return {data: this.issueList, courses: this.props.courses }
  },
  componentDidMount: function() {
    this.refreshIssues(this.state.courses);
  },
  componentWillReceiveProps: function(nextProps) {
    this.setState({courses: nextProps.courses});
    this.refreshIssues(nextProps.courses);
  },
  render: function() {
    return (
      <IssueList data={this.state.data} />
    );
  }
});

var Timeline = React.createClass({
  updateEnabled: false,
  updateScheduled: false,
  isLoaderOnScreen: function() {
    var viewportBottom = $(window).scrollTop() + $(window).height();
    return $("#loader").offset().top <= viewportBottom;
  },
  getInitialState: function() {
    return {noMoreUpdate: false, courses: []};
  },
  enableUpdate: function() {
    updateEnabled: true;
    $("#more-button").hide();
    this.scheduleUpdate();
    window.addEventListener('scroll', this.scheduleUpdate);
  },
  scheduleUpdate: function(data) {
    if(!this.updateScheduled && this.isLoaderOnScreen()) {
      this.updateScheduled = true;
      $("#loader").addClass("active");
      setTimeout(() => { this.refs.issueContainer.loadMoreIssues(this.state.courses); }, 1000);
    }
  },
  updateDone: function(length) {
    this.updateScheduled = false;
    $("#loader").removeClass("active");

    if (length < 5) {
      window.removeEventListener('scroll', this.scheduleUpdate);
    }
  },
  reset: function(data) {
    this.refs.issueContainer.refreshIssues(this.state.courses);
  },
  componentDidMount: function() {
    $.get({
      url: this.props.coursesUrl,
      success: (data) => {
        data = JSON.parse(data);
        var courses = data.courses.map(function(course) {
          course['checked'] = true;
          return course;
        });
        this.setState({courses: courses});
      }
    });
  },
  render: function() {
    return (
      <div>
        <ToggleButtonList data={this.state.courses} onToggle={this.reset} />
        <IssueContainer id="issue-container" url={this.props.updateUrl} courses={this.state.courses}
          how_many={5} update_done={this.updateDone} ref="issueContainer" />
        <div className="ui button" onClick={this.enableUpdate} id="more-button">더 보기</div>
        <div className="ui inline text loader" id="loader" ref="loader" >긁어오는 중</div>
      </div>
    );
  }
});

var ToggleButtonList = React.createClass({
  getInitialState: function() {
    return ({data: this.props.data});
  },
  componentWillReceiveProps: function(nextProps) {
    this.setState({data: nextProps.data});
  },
  toggle: function(index) {
    var data = this.state.data;
    if (data[index].checked) {
      data[index].checked = false;
    } else {
      data[index].checked = true;
    }

    this.props.onToggle(data);
    this.setState({data: data});
  },
  render: function() {
    var list = this.state.data.map((course, index) => {
      var color = ['blue', 'purple', 'red', 'orange', 'olive', 'green', 'teal', 'brown', 'pink', 'violet']
      var buttonClass = "ui circular button ";
      if (course.checked) {
        buttonClass += color[course.title.length % 10];
      } else {
        buttonClass += "grey";
      }
      return (<div className={buttonClass} key={course.id} onClick={() => {this.toggle(index)}}>
        {course.title[0]}
      </div>);
    });
    return (<div className="ui horizontal list">
      {list}
    </div>);
  }
});

function setTimeline(container, coursesUrl, updateUrl) {
  var timeline = ReactDOM.render(
    <Timeline coursesUrl={coursesUrl} updateUrl={updateUrl} />,
    $(container).get(0)
  );

  return timeline;
}
