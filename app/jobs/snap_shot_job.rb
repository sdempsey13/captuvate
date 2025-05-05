require "open-uri"

class SnapShotJob < ApplicationJob
  queue_as :default

  def perform(domain)
    SnapShotService.new(domain).call
  end
end
