// Function called when document is loaded
function userDocumentLoad() {
  $("#desc_input").hide();
}

// Function called when description edition start
function descEdit() {
  $(".description").hide();
  $("#desc_input").show();
}

// Function called when description edition cancled
function descCancle() {
  $(".description").show();
  $("#desc_input").hide();
}

// Function called when description edition saved
function descSave() {
  var desc = $("#input_desc").val();
  $.post(
    "profile/update_desc",
    { desc : desc },
    function(result) {
      $("#desc_text").text(result);
  });

  $(".description").show();
  $("#desc_input").hide();
}


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
  updateEnabled: false,
  updateScheduled: false,
  isLoaderOnScreen: function() {
    var viewportBottom = $(window).scrollTop() + $(window).height();
    return $("#loader").offset().top <= viewportBottom;
  },
  getInitialState: function() {
    return {noMoreUpdate: false};
  },
  enableUpdate: function() {
    updateEnabled: true;
    $("#more-button").hide();
    this.scheduleUpdate();
    window.addEventListener('scroll', this.scheduleUpdate);
  },
  scheduleUpdate: function() {
    if(!this.updateScheduled && this.isLoaderOnScreen()) {
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
  },
  render: function() {
    return (
      <div>
        <IssueContainer id="issue-container" url={this.props.url}
          how_many={5} update_done={this.updateDone} ref="issueContainer" />
        <div className="ui button" onClick={this.enableUpdate} id="more-button">더 보기</div>
        <div className="ui inline text loader" id="loader" ref="loader" >긁어오는 중</div>
      </div>
    );
  }
});

function setIssueTimeline(container, url) {
  var timeline = ReactDOM.render(
    <Timeline url={url} />,
    $(container).get(0)
  );

  return timeline;
}
