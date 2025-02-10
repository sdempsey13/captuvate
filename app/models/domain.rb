class Domain < ApplicationRecord
  belongs_to :user

  has_many :snap_shots, dependent: :destroy

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
