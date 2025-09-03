class VwoWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def receive
    # when we're done writing this, just wrap it all up in a job so we don't ever stop the servers for these
    # ConsumeWebhookJob.perform_later(request)
    raw_body = request.body.read

    signature = request.headers['x-vwo-auth']

    payload = JSON.parse(raw_body)

    #find this companies api_credential
    #either match it off the secret key? or info in the payload, like account_id from VWO side
    binding.pry
    api_credential = find_api_credential(signature)
    
    def find_api_credential(signature)
      WebhookCredential.where(encrypted_secret_key: signature).first.organization.api_credentials.first
    end

    binding.pry
    PlatformSyncOrchetsatorJob.perform_later(api_credential)

    head :ok
  rescue JSON::ParserError => e
    Rails.logger.error("Invalid JSON in VWO webhook: #{e.message}")
    head :bad_request
  end

  private

  def verify_signature!(body, signature)
    expected = OpenSSL::HMAC.hexdigest("SHA256", Rails.application.credentials.vwo[:webhook_secret], body)
    raise "Invalid signature" unless Rack::Utils.secure_compare(expected, signature)
  end
end