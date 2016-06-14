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
  render: function() {
    var list = this.props.data.map(function(professor) {
      return (
        <ProfessorInfo data={professor} key={professor.id} />
      )
    });

    return (
      <div className="ui items">
        {list}
      </div>
    );
  }
});

var ProfessorPopup = React.createClass({
  searchSchedule: null,
  getProfessor: function(name) {
    $.get({
      url: this.props.url,
      data: { name: name },
      success: (data) => {
        this.setState({isLoading: false, data: JSON.parse(data).professors });
      }
    });
  },
  getInitialState: function() {
    return { data: [], isLoading: false };
  },
  componentDidMount: function() {
    var searchBox = $(this.props.search_box);
    searchBox.on('input', () => {
      if (searchBox.val().length == 0) {
        searchBox.popup('hide');
      } else {
        if (searchBox.popup('is hidden')) {
          searchBox.popup('show');
        }
        if (!this.state.isLoading) {
          this.setState({isLoading: true});
        }
        clearTimeout(this.searchSchedule);
        this.searchSchedule = setTimeout(() => {
          this.getProfessor(searchBox.val());
        }, 600);
      }
    });
  },
  render: function() {
    var contents;
    if (this.state.isLoading) {
      contents = <div className='ui active inline centered loader'></div>;
    } else if (this.state.data.length > 0) {
        contents = <ProfessorList data={this.state.data} />;
    } else {
      contents = <p>음슴</p>;
    }

    return (
      <div className="ui">
        {contents}
      </div>
    );
  }
});

function initProfessorFinder(searchBox, popup, searchUrl) {
  var $searchBox = $(searchBox);
  $searchBox.popup({
    popup: popup,
    position: 'bottom left',
    on: 'manual',
    contents: "<div id='popup' ></div>",
    hideOnScroll: false
  });

  $searchBox.popup('show');

  var popup = $searchBox.popup('get popup')[0];

  ReactDOM.render(
    <ProfessorPopup url={searchUrl} search_box={searchBox}/>,
    popup
  );
}
