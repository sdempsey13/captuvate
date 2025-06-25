class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  layout :set_devise_layout

  include Pundit::Authorization
  include PathUtils

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  private

  def set_devise_layout
    devise_controller? ? 'devise' : nil
  end

  def not_authorized
    flash[:alert] = "You are not permitted to view that page."
    redirect_to domains_path
  end
end
