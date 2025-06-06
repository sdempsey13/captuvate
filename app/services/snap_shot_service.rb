class SnapShotService
  VIEWPORTS = {
    desktop: { width: 1920, height: 1080 },
    mobile:  { width: 375,  height: 812 }
  }.freeze

  def initialize(domain)
    @domain = domain
  end

  def call
    puts "start snap shot job for domain #: #{@domain.id}"

    if @domain.collects_mobile
      puts 'collecting mobile'
      format = 'mobile'

      create_snap_shot(format)
      puts 'mobile snap shot created'
      result = fetch_response(format)
      puts 'recieved mobile url'
      attach_img_to_snap_shot(result) if result['screenshot']
      puts 'attached mobile screenshot'
      attach_html_to_snap_shot(result) if result['extracted_html']
      puts 'attached html'
    end

    if @domain.collects_desktop
      puts 'collecting desktop'
      format = 'desktop'

      create_snap_shot(format)
      puts 'desktop snap shot created'
      result = fetch_response(format)
      puts 'received desktop url'
      attach_img_to_snap_shot(result) if result['screenshot']
      puts 'attached desktop screenshot'
      attach_html_to_snap_shot(result) if result['extracted_html']
      puts 'attached html'
    end

  end

  private

  def create_snap_shot(format)
    @snap_shot = SnapShot.create!(domain_id: @domain.id, format: format)
  end

  def fetch_response(format)
    token = Rails.application.credentials.dig(:screen_shot_api, :private_key)
    url = CGI.escape(@domain.url)
    
    query = "https://shot.screenshotapi.net/v3/screenshot?"
    query += set_screenshot_options(token, url, format).to_query
    
    response = Net::HTTP.get_response(URI.parse(query))
    result = JSON.parse(response.body)

    return result if response.code == "200"

    puts "Error: #{response.code} - #{response.message}"
    nil
  end

  def attach_img_to_snap_shot(result)
    file = URI.open(result['screenshot'])
    
    @snap_shot.screen_shot.attach(
      io: file,
      filename: "#{@snap_shot.id}.png",
      content_type: 'image/png'
    )
  end

  def attach_html_to_snap_shot(result)
    file = URI.open(result['extracted_html'])

    @snap_shot.html_file.attach(
      io: file,
      filename: "#{@snap_shot.id}.html",
      content_type: "text/html"
    )
  end

  def set_screenshot_options(token, url, format)
    {
      token: token,
      url: url,
      output: 'json',
      file_type: 'png',
      width: VIEWPORTS[format.to_sym][:width],
      height: VIEWPORTS[format.to_sym][:height],
      full_page: true,
      fresh: true,
      extract_html: true,
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