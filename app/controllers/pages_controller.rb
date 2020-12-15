class PagesController < ApplicationController
  def home
     @symptoms = Symptom.all
  end
end
