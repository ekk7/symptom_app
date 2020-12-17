class Symptom < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title
  validate :future_completed_date
  validates_presence_of :user

  private

  def future_completed_date
    if !date.blank? && date > Date.today
      self.errors.add(:date, "Date can't be in the future")
    end
  end
end
