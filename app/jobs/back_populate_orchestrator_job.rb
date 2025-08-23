class BackPopulateOrchestratorJob < ApplicationJob
  queue_as :default

  def perform(integration_credential)
    integration = determine_integration(integration_credential)
  end

  private

  def determine_integration(integration_credential)
    case integration_credential.integration.name
    when 'VWO'
      VwoBackPopulateJob.perform_later(integration_credential)
    end
  end
end
  