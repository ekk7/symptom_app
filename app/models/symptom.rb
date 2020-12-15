class Symptom < ActiveRecord::Base
  validates_presence_of :title
  validate :future_completed_date

  private

  def future_completed_date
    if !date.blank? && date > Date.today
      self.errors.add(:date, "Date can't be in the future")
    end
  end
end
