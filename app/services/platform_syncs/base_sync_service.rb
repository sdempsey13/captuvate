module PlatformSyncs
  class BaseSyncService
    def initialize(api_credential)
      @api_credential = api_credential
    end

    def sync!
      raise NotImplementedError, "Each ingestor must implement #sync!"
    end

    private

    attr_reader :api_credential
  end
end