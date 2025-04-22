class SiteRole < ApplicationRecord
  belongs_to :user

  enum :role, { admin: 0, client: 1 }
end
