class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include Pundit::Authorization
  include PathUtils

  def after_sign_in_path_for(resource)
    domains_path
  end
end
