module PlatformSyncs
  class VwoSyncService < BaseSyncService
    require 'uri'
    require 'net/http'
    require 'json'
    
    def sync!
      response = call_vwo_api(@api_credential)
      json_data = parse_response_to_json(response)

      rows = collect_rows(json_data)
      upsert_rows(rows)
    end

    private

    def call_vwo_api(api_credential)
      url = URI("https://app.vwo.com/api/v2/accounts/current/campaigns?limit=25&offset=0")
  
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
  
      request = Net::HTTP::Get.new(url)
      request["accept"] = 'application/json'
      request["token"] = api_credential.encrypted_api_key
  
      response = http.request(request)
    end
  
    def parse_response_to_json(response)
      ActiveSupport::JSON.decode(response.body)["_data"]
    end

    def collect_rows(json_data)
      json_data.map do |campaign|
        {
          name:                 campaign["name"],
          integration_id:       @api_credential.integration.id,
          organization_id:      @api_credential.organization.id,
          external_id:          campaign["id"],
          status:               campaign["status"],
          campaign_created_at:  Time.at(campaign["createdOn"]),
          campaigns_metadata:   campaign
        }
      end
    end

    def upsert_rows(rows)
      Campaign.upsert_all(rows, unique_by: :index_campaigns_on_external_platform_org)
    end
  end
end