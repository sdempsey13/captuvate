class Campaign < ApplicationRecord
  validates :external_id, presence: true
  validates :source, presence: true  

  belongs_to :organization
end
