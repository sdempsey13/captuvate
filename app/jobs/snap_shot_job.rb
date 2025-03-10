require "open-uri"

class SnapShotJob < ApplicationJob
  queue_as :default

  def perform(domain)
    create_snap_shot(domain)
    screenshot_url = fetch_screen_shot_url(domain)
    attach_img_to_snap_shot(screenshot_url) if screenshot_url
    puts 'finished screenshot job'
  end

  private

  def create_snap_shot(domain)
    @snap_shot = SnapShot.create!(domain_id: domain.id)
  end

  def fetch_screen_shot_url(domain)
    token = Rails.application.credentials.dig(:screen_shot_api, :private_key)
    url = CGI.escape(domain.url)
    
    query = "https://shot.screenshotapi.net/v3/screenshot?"
    query += set_screenshot_options(token, url).to_query
    
    response = Net::HTTP.get_response(URI.parse(query))
    result = JSON.parse(response.body)

    return result['screenshot'] if response.code == "200"

    puts "Error: #{response.code} - #{response.message}"
    nil
  end

  def attach_img_to_snap_shot(screenshot_url)
    file = URI.open(screenshot_url)
    
    @snap_shot.screen_shot.attach(
      io: file,
      filename: "#{@snap_shot.id}.png",
      content_type: 'image/png'
    )
  end

  def set_screenshot_options(token, url)
    {
      token: token,
      url: url,
      output: 'json',
      file_type: 'png',
      width: 1920,
      height: 1080,
      full_page: true,
      fresh: true,
      # wait_for_page_load: true,
      # delay: 3, # Wait 3 seconds after page load
      # retina: true,
      accept_language: 'en-US,en;q=0.8',
      no_cookie_banners: true,
      lazy_load: true,
      # remove_selectors: '.modal, .popup, .cookie-banner, .newsletter-popup, #gdpr-consent, .intercom-lightweight-app' # Close common pop-ups
    }
  end
end
