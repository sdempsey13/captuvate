require "uri"
require "net/http"

class SnapShotJob < ApplicationJob
  queue_as :default

  require "ferrum"

  attr_accessor :file_name, :snap_shot

  def perform(domain)
    @file_name = "#{domain.id}-#{DateTime.now.strftime('%Y%m%d%I%M%S')}.png"
    @file_path = Rails.root.join("storage", @file_name)
    
    create_snap_shot(domain)
    take_screen_shot(domain)
    attach_img_to_snap_shot
    puts 'finished screenshot job'
  end

  private

  def create_snap_shot(domain)
    snap_shot = SnapShot.new(domain_id: domain.id)
    snap_shot.save!
    @snap_shot = snap_shot
  end

  def take_screen_shot(domain)
    token = Rails.application.credentials.dig(:screen_shot_api, :private_key)
    url = CGI.escape(domain.url)
    output = "json"
    file_type = "png"
    fresh = 'true'

    query = "https://shot.screenshotapi.net/v3/screenshot"
    query += "?token=#{token}&url=#{url}&output=#{output}&file_type=#{file_type}&fresh=#{fresh}"
    
    # Send a GET request to the API
    uri = URI.parse(query)
    response = Net::HTTP.get_response(uri)
    result = JSON.parse(response.body)
    url = result['screenshot']

    if response.code == "200"
      File.open(@file_path, "wb") do |f|
        f.write HTTParty.get(url).body
      end
      puts "The file was saved!"
    else	
      puts "Error: #{response.code} - #{response.message}"
    end
  end

  def attach_img_to_snap_shot
    @snap_shot.screen_shot.attach(
      io: File.open(@file_path),
      filename: File.basename(@file_path),
      content_type: 'image/png'
    )
  end

  private

  def query_params
    default_options = {
      token: Rails.application.credentials.dig(:screen_shot_api, :private_key),
      url: CGI.escape("https://www.google.com"),
      output: 'json',
      file_type: 'png',
      width: 1920,
      height: 1080,
      full_page: true,
      fresh: true, # Always use fresh screenshots
      wait_for_page_load: true,
      delay: 3, # Wait 3 seconds after page load
      retina: true, # Capture at 2x resolution
      accept_language: 'en-US,en;q=0.8', # Specify English - United States
      no_cookie_banners: true, # Remove cookie banners
      lazy_load: true, # Ensure lazy-loaded content is loaded
      remove_selectors: '.modal, .popup, .cookie-banner, .newsletter-popup, #gdpr-consent, .intercom-lightweight-app' # Close common pop-ups
    }
  end

  def base_query
    "https://shot.screenshotapi.net/v3/screenshot"
  end

  def build_request_query

  end
end
  