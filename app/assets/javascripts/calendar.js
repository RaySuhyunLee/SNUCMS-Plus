// calendar loading function
function calendarLoad() {
  var events_array = [
    {
      title: 'All day event',
      start: '2016-06-16'
    }];

  $("#calendar").fullCalendar({
    header: {
      left: 'prevYear,nextYear',
      center: 'title',
      right: 'today prev,next'
    },
    events: events_array
  });
}
