class VwoBackPopulateJob < ApplicationJob
  queue_as :default

  require 'uri'
  require 'net/http'
  require 'json'

  def perform(integration_credential)
    response = call_vwo_api(integration_credential)
    json_data = parse_response_to_json(response)
    VwoCampaignIngestorService.new(json_data).ingest!
  end

  private

  def call_vwo_api(integration_credential)
    url = URI("https://app.vwo.com/api/v2/accounts/current/campaigns?limit=25&offset=0")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["token"] = integration_credential.encrypted_api_key

    response = http.request(request)
  end

  def parse_response_to_json(response)
    ActiveSupport::JSON.parse(response.body)["_data"]
  end
end
