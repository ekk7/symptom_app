require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

class SymptomsController < ApplicationController

  def new
    @symptom = Symptom.new
    render :show_form
  end

  def create

    @symptom = Symptom.new(symptom_params)
    @symptom.user = current_user
    authorize! :create, @symptom
    save_symptom

  end


  def destroy
    @symptom = Symptom.find(params[:id])
    authorize! :destroy, @symptom
    @symptom.destroy
    @symptoms = Symptom.all
  end

  def edit
    @symptom = Symptom.find(params[:id])
    authorize! :edit, @symptom
    render :show_form
  end

  def update
    @symptom = Symptom.find(params[:id])
    @symptom.update(symptom_params)
    authorize! :update, @symptom
    save_symptom
  end


  private

  def save_symptom
    if @symptom.save
      @symptoms = Symptom.accessible_by(current_ability)
      render :hide_form
    else
      render :show_form
    end
  end

  def symptom_params
    params.require(:symptom).permit(:title, :note, :date, :rating)
  end
end
