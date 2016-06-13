
var IssueList = React.createClass({
  render: function() {
    var issueFeeds = this.props.data.map( function(issue) {
      return (
        <div className="item">
          <a className="header" href={issue.parent_url} >
            {issue.parent_title}
          </a>
          <div className="content">
            {issue.title} <br/>
            {issue.created_at}
          </div>
        </div>
      );
    });
    return (
      <div className="ui relaxed devided list">
        {issueFeeds}
      </div>
    );
  }
}); 

var IssueContainer = React.createClass({
  count: 0,
  issueList: [],
  loadIssues: function() {
    $.get({
      url: this.props.url,
      data: { offset: this.count, how_many: this.props.how_many },
      success: (result) => {
        var issues = JSON.parse(result).issues;
        this.issueList = this.issueList.concat(issues);
        this.count += issues.length;
        this.setState({data: this.issueList});
        this.props.update_done(issues.length);
      }
    });
  },
  getInitialState: function() {
    return {data: this.issueList}
  },
  componentDidMount: function() {
    this.loadIssues();
  },
  render: function() {
    return (
      <IssueList data={this.state.data} />
    );
  }
});

var Timeline = React.createClass({
  updateScheduled: false,
  noMoreUpdate: false,
  isLoaderOnScreen: function() {
    var viewportBottom = $(window).scrollTop() + $(window).height();
    return $("#loader").offset().top <= viewportBottom;
  },
  getInitialState: function() {
    return {noMoreUpdate: false};
  },
  scheduleUpdate: function() {
    if(!this.noMoreUpdate && !this.updateScheduled && this.isLoaderOnScreen()) {
      this.updateScheduled = true;
      $("#loader").addClass("active");
      setTimeout(() => { this.refs.issueContainer.loadIssues(); }, 1000);
    }
  },
  updateDone: function(length) {
    this.updateScheduled = false;
    $("#loader").removeClass("active");

    if (length < 5) {
      window.removeEventListener('scroll', this.scheduleUpdate);
    }
  },
  componentDidMount: function() {
    window.addEventListener('scroll', this.scheduleUpdate);
  },
  render: function() {
    return (
      <div>
        <IssueContainer id="issue-container" url={this.props.url}
          how_many={5} update_done={this.updateDone} ref="issueContainer" /> 
        <div className="ui inline text loader" id="loader" ref="loader" >긁어오는 중</div>
      </div>
    );
  }
});

function setTimeline(container, url) {
  var timeline = ReactDOM.render(
    <Timeline url={url} />,
    $(container).get(0)
  );

  return timeline;
}
