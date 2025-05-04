class Domain < ApplicationRecord
  belongs_to :user

  has_many :snap_shots, dependent: :destroy

  has_one :domain_schedule, dependent: :destroy
  accepts_nested_attributes_for :domain_schedule

  validates :url, presence: true, uniqueness: { scope: :user_id, message: "must be unique" }

  after_create :capture_snapshots

  private
  def capture_snapshots
    SnapShotJob.perform_later(self)
  end
end
