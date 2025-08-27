class PlatformSyncOrchestratorJob < ApplicationJob
  queue_as :default

  def perform(integration_credential)
    run_integration(integration_credential)
  end

  private

  def run_integration(integration_credential)
    integration = integration_credential.integration

    adapter_class = IntegrationRegistry.adapter_for(integration.platform)
    adapter_class.new(integration_credential).sync! 
  end
end
