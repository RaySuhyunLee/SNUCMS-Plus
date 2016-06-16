class CalendarController < ApplicationController
  def show
    @clndr = Clndr.new(:simple)
    @clndr.start_with_month = Time.now - 1.year
    @clndr.add_event(Time.now, 'Event!', description:'loc is <%%= event.location %>')
  end
end
