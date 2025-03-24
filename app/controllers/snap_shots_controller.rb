class SnapShotsController < ApplicationController
  before_action :set_snap_shot, only: %i[ show ]
  before_action :authenticate_user!

  def show
    @domains = current_user.domains
    @snap_shots = current_user.snap_shots
  end

  def create
    SnapShotJob.perform_later(Domain.find(params[:id]))
  end

  private
  def set_snap_shot
    @snap_shot = SnapShot.find(params.expect(:id))
  end
end