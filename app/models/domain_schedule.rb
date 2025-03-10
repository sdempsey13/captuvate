class DomainSchedule < ApplicationRecord
  belongs_to :domain
  
  enum :frequency, { hourly: 0, daily: 1, weekly: 2, monthly: 3 }

  scope :active, -> { where(active: true) }
  scope :by_frequency, ->(freq) { where(frequency: freq) }
end
