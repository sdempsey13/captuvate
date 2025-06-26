class Integration < ApplicationRecord
  validates :name, presence: true

  has_many :integration_credentials
end
