class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include PathUtils

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  layout :set_devise_layout

  helper_method :current_organization

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :email,
      :password,
      :password_confirmation,
      organization_attributes: [:name]
    ])
  end

  def current_organization
    return @current_organization if defined?(@current_organization)

    if current_user.site_admin? && params[:organization_id]
      @current_organization = Organization.find_by(id: params[:organization_id])
    else
      @current_organization = current_user.organization
    end
  end

  def set_devise_layout
    devise_controller? ? 'devise' : nil
  end

  def not_authorized
    flash[:alert] = "You are not permitted to view that page."
    redirect_to domains_path
  end
end
