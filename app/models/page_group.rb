class PageGroup < ApplicationRecord
  has_many :pages, dependent: :destroy
end
