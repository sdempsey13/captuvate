class VwoBackPopulateJob < ApplicationJob
  queue_as :default

  require 'uri'
  require 'net/http'

  def perform(integration_credential)
    binding.pry
    ## make an API request to get all of the campaings for 
    response = call_vwo_api(integration_credcential)
    
    # Cycle through each campaign and save/update them
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
end
