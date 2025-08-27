class VwoWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def receive
    raw_body = request.body.read

    signature = request.headers['x-vwo-auth']

    verify_signature!(raw_body, signature)

    payload = JSON.parse(raw_body)

    VwoCampaignIngestor.new(payload.to_json).ingest!

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