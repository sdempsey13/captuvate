class Domain < ApplicationRecord
  belongs_to :user

  has_many :snap_shots, dependent: :destroy

  has_one :domain_schedule, dependent: :destroy
  accepts_nested_attributes_for :domain_schedule

  validates :url, presence: true

  after_create :setup_snapshots

  private
  def setup_snapshots
    # Que the job to setup a new snap_shot
    SnapShotJob.perform_later(self)

    # set up the recurring schedule for future snapshots
    # Schedule.new
  end
end
