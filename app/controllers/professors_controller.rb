class ProfessorsController < ApplicationController
  # GET /professors/find
  def find
    name = params[:name]
    professors = Professor.where('name LIKE ?', '%' + name + '%')

    respond_to do |format|
      format.all { render json: { professors: professors } }
    end
  end
end
