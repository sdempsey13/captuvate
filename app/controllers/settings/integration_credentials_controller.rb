module Settings
  class IntegrationCredentialsController < ApplicationController
    before_action :authenticate_user!
    def index
      @integration_credentials = current_organization.integration_credentials
      @integration_credential = IntegrationCredential.new
    end

    def create
      @integration_credential = current_organization.integration_credentials.build(integration_credentials_params)
      @integration_credential.organization_id = current_organization.id

      if @integration_credential.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to settings_api_keys_path, notice: 'API stored successfully' }
        end
      else
        @integration_credentials = current_organization.integration_credentials
    
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace(
              "integration_credential_form",
              partial: "settings/integration_credentials/form",
              locals: { integration_credential: @integration_credential }
            )
          end
    
          format.html { render :index, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @integration_credential = IntegrationCredential.find(params[:id])
      @integration_credential.destroy

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to settings_api_keys_path, notice: "API deleted"}
      end
    end

    private

    def integration_credentials_params
      params.require(:integration_credential).permit(:encrypted_api_key, :integration_id)
    end
  end
end
