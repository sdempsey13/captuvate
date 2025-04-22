module Admin
  class BaseController < ApplicationController

    rescue_from Pundit::NotAuthorizedError, with: :admin_not_authorized

    private

    def admin_not_authorized
      flash[:alert] = "You are not permitted to view that page."
      redirect_to domains_path
    end
  end
end
  