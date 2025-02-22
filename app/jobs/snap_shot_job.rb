class SnapShotJob < ApplicationJob
    queue_as :default
  
    require "selenium-webdriver"

    attr_accessor :file_name, :snap_shot

    def perform(domain)
      puts "creating snapshot"
      create_snap_shot(domain)
      puts "setting file name"
      set_file_name(domain)
      puts "taking screen shot"
      take_snap_shot(domain)
      puts "attaching image to snap shot"
      attach_img_to_snap_shot
    rescue StandardError => e
      puts "Error creating Selenium WebDriver: #{e.message}"
      puts e.backtrace
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

    def take_snap_shot(domain)
      puts "options"
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument("--headless")
      options.add_argument("--no-sandbox")
      options.add_argument("--disable-dev-shm-usage")
      options.add_argument("--disable-gpu")
      options.add_argument("--window-size=1280x1024")

      puts "driver"
      driver = Selenium::WebDriver.for :chrome, options: options
      
      puts "navigate to"
      driver.navigate.to domain.url

      full_height = driver.execute_script("return document.body.scrollHeight")

      puts "resize"
      driver.manage.window.resize_to(1280, full_height)

      puts "save"
      puts "#{@file_name}"
      driver.save_screenshot("storage/#{@file_name}")
      driver.quit
    end

    def attach_img_to_snap_shot
      file_path = Rails.root.join('storage', "#{@file_name}")

      @snap_shot.screen_shot.attach(
        io: File.open(file_path),
        filename: File.basename(file_path),
        content_type: 'image/png'
      )
    end
  end
  