class SymptomsController < ApplicationController
  def new
    @symptom = Symptom.new
    render :show_form
  end

  def create
    @symptom = Symptom.create(symptom_params)
    save_symptom
  end

  def destroy
    @symptom = Symptom.find(params[:id])
    @symptom.destroy
    @symptoms = Symptom.all
  end

  def edit
    @symptom = Symptom.find(params[:id])
    render :show_form
  end

  def update
    @symptom = Symptom.find(params[:id])
    @symptom.update(symptom_params)
    save_symptom
  end

  private

  def save_symptom
    if @symptom.save
      @symptoms = Symptom.all
      render :hide_form
    else
      render :show_form
    end
  end

  def symptom_params
    params.require(:symptom).permit(:title, :note, :date, :rating)
  end
end
