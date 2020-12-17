class PagesController < ApplicationController
  def home
     @symptoms = Symptom.accessible_by(current_ability)
  end
end
