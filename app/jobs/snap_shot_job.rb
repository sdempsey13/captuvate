class SnapShotJob < ApplicationJob
    queue_as :default
  
    require "ferrum"

    attr_accessor :file_name, :snap_shot

    def perform(domain)
      create_snap_shot(domain)
      set_file_name(domain)
      take_screen_shot(domain)
      attach_img_to_snap_shot
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
      browser = Ferrum::Browser.new(
        headless: true,
        browser_options: { "no-sandbox" => nil },
        browser_path: Rails.root.join("bin/chrome-linux/chrome").to_s
      )

      browser.go_to(domain.url)
  
      browser.network.wait_for_idle
  
      browser.screenshot(path: "storage/#{@file_name}", full: true)
      browser.quit
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
  