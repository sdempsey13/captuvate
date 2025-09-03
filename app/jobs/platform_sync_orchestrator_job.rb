class PlatformSyncOrchestratorJob < ApplicationJob
  queue_as :default

  def perform(api_credential)
    run_integration(api_credential)
  end

  private

  def run_integration(api_credential)
    integration = api_credential.integration

    adapter_class = IntegrationRegistry.adapter_for(integration.integration_type.key)
    adapter_class.new(api_credential).sync! 
  end
end
