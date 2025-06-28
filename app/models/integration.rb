class Integration < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :integration_credentials
end
