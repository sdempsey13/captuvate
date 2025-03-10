class SnapShotOrchestratorJob < ApplicationJob
  queue_as :default

  def perform(schedule)
    puts 'snap shot orchestrator'
    # collect_domains(schedule)
    # queue_snap_shot_jobs
    # puts 'finished snap shot orchestrator job'
  end

  private

  def collect_domains(schedule)
    DomainSchedule.active.by_frequency(schedule)
  end

  def queue_snap_shot_jobs
    SnapShotJob.perform_later()
  end
end
