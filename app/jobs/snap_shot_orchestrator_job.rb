class SnapShotOrchestratorJob < ApplicationJob
  queue_as :default

  def perform(schedule)
    puts 'start snap shot orchestrator'
    domains = collect_domains(schedule)
    puts "#{domains.count}"
    queue_snap_shot_jobs(domains)
    puts 'finish snap shot orchestrator job'
  end

  private

  def collect_domains(schedule)
    DomainSchedule.active.by_frequency(schedule.to_sym)
  end

  def queue_snap_shot_jobs(domains)
    domains.each do |domain|
      SnapShotJob.perform_now(domain)
    end
  end
end
