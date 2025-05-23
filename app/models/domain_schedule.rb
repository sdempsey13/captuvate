class DomainSchedule < ApplicationRecord
  belongs_to :domain
  
  enum :frequency, { daily: 0, weekly: 1, monthly: 2 }

  scope :active, -> { where(active: true) }
  scope :by_frequency, ->(freq) { where(frequency: freq) }

  def toggle_status
    update(active: !active)
  end

  def strf_status
    self.active? ? "Active" : "Inactive"
  end
end
