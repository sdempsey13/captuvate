module Admin
  class DomainUploaderController < BaseController
    before_action :authorize_admin

    def new
    end

    def create
    end

    private

    def authorize_admin
      authorize [:admin, :domain_uploader]
    end
  end
end