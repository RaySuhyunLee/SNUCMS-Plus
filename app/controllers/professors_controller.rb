class ProfessorsController < ApplicationController
  # GET /professors/find
  def find
    name = params[:name]
    professors = Professor.where('name LIKE ?', '%' + name + '%')
    
    data = []
    professors.each do |professor|
      data.append({
        name: "<img src='#{professor.picture}' /><span class='name'>#{professor.name}</span>",
        value: professor.id
      });
    end

    respond_to do |format|
      format.all { render json: { success: true, results: data } }
    end
  end
end
