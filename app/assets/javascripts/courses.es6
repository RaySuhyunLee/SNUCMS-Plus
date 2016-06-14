var ProfessorInfo = React.createClass({
  render: function() {
    return (
      <div className="item">
        <div className="ui tiny image">
          <img src={this.props.data.picture} />
        </div>
        <div className="content">
          <p className="header">{this.props.data.name}</p>
          <div className="meta">
          </div>
        </div>
      </div>
    );
  }
});

var ProfessorList = React.createClass({
  dropdown: null,
  searchSchedule: null,
  getProfessor: function(name) {
    $.get({
      url: this.props.url,
      data: { name: name },
      success: (data) => {
        this.dropdown.removeClass("loading");
        this.setState({isLoading: false, data: JSON.parse(data).professors });
      }
    });
  },
  componentDidMount: function() {
    this.dropdown = $(this.props.dropdown);
    this.dropdown.dropdown();
    var input = this.dropdown.find(".search");
    input.change(() => {
      if (!this.state.isLoading) {
        this.setState({isLoading: true});
        this.dropdown.addClass("loading");
      }
      clearTimeout(this.searchSchedule);
      this.searchSchedule = setTimeout(() => {
        this.getProfessor(input.val());
      }, 600);
    });
  },
  getInitialState: function() {
    return { data: [], isLoading: false };
  },
  render: function() {
    var list = this.state.data.map(function(professor) {
      return (
        <ProfessorInfo data={professor} key={professor.id} />
      )
    });

    return (
      <div>
        {list}
      </div>
    );
  }
});

function initProfessorFinder(dropdown, container, searchUrl) {
  ReactDOM.render(
    <ProfessorList dropdown={dropdown} url={searchUrl} />,
    $(container)[0]
  );
}
