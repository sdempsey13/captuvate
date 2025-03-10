class DomainSchedule < ApplicationRecord
  belongs_to :domain
  
  enum :frequency, { minutely: 0, hourly: 1, daily: 2, weekly: 3, monthly: 4 }

  scope :active, -> { where(active: true) }
  scope :by_frequency, ->(freq) { where(frequency: freq) }
end
