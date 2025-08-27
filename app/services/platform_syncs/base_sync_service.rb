module PlatformSyncs
  class BaseSyncService
    def initialize(integration_credential)
      @integration_credential = integration_credential
    end

    def sync!
      raise NotImplementedError, "Each ingestor must implement #sync!"
    end

    private

    attr_reader :integration_credential
  end
end