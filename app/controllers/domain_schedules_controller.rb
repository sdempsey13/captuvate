class DomainSchedulesController < ApplicationController
  before_action :set_domain_schedule
  before_action :authenticate_user!

  def set_activation
    @domain_schedule.toggle_status
    redirect_back(fallback_location: root_path)
  end

  private
  def set_domain_schedule
    @domain_schedule = DomainSchedule.find(params.expect(:id))
  end
end