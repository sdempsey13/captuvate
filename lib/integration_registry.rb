class IntegrationRegistry
  REGISTRY = {
    IntegrationPlatforms::VWO => {
      adapter: PlatformSyncs::VwoSyncService,
      display_name: 'VWO'
    } 
  }.freeze

  def self.adapter_for(platform)
    REGISTRY.fetch(platform)[:adapter]
  end

  def self.supported_platforms
    REGISTRY.keys
  end
end