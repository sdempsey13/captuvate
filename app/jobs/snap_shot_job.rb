require "uri"
require "net/http"

class SnapShotJob < ApplicationJob
  queue_as :default

  require "ferrum"

  attr_accessor :file_name, :snap_shot

  def perform(domain)
    create_snap_shot(domain)
    set_file_name(domain)
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

  def set_file_name(domain)
    @file_name = "#{domain.id}-#{DateTime.now.strftime('%Y%m%d%I%M%S')}.png"
  end

  def take_screen_shot(domain)
    # Define your API Key, URL, output type, and file type
    token = Rails.application.credentials.dig(:screen_shot_api, :private_key)
    url = CGI.escape("https://www.google.com")
    output = "json"
    file_type = "png"
    fresh = 'true'


    # Construct the query URL
    # query = "https://shot.screenshotapi.net"
    query = "https://shot.screenshotapi.net/v3/screenshot"
    query += "?token=#{token}&url=#{url}&output=#{output}&file_type=#{file_type}&fresh=#{fresh}"
    
    # Send a GET request to the API
    uri = URI.parse(query)
    response = Net::HTTP.get_response(uri)
    result = JSON.parse(response.body)
    url = result['screenshot']
    # Check if the response was successful
    if response.code == "200"	# Save the screenshot as a binary file
      File.open(Rails.root.join("storage", @file_name), "wb") do |f|
        f.write HTTParty.get(url).body
      end
      puts "The file was saved!"
    else	
      puts "Error: #{response.code} - #{response.message}"
    end
  end

  def attach_img_to_snap_shot
    # file_path = Rails.root.join('storage', "#{@file_name}")

    # @snap_shot.screen_shot.attach(
    #   io: File.open(file_path),
    #   filename: File.basename(file_path),
    #   content_type: 'image/png'
    # )
  end
end
  