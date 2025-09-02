module Settings
  class ApiCredentialsController < ApplicationController
    
    def index
      @api_credentials = current_organization.api_credentials
      @api_credential = ApiCredential.new
    end

    def create
      @api_credential = current_organization.api_credentials.build(api_credentials_params)
      @api_credential.organization_id = current_organization.id

      if @api_credential.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to settings_api_keys_path, notice: 'API stored successfully' }
        end
      else
        @api_credentials = current_organization.api_credentials
    
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace(
              "api_credential_form",
              partial: "settings/api_credentials/form",
              locals: { api_credential: @api_credential }
            )
          end
    
          format.html { render :index, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @api_credential = ApiCredential.find(params[:id])
      @api_credential.destroy

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to settings_api_keys_path, notice: "API deleted"}
      end
    end

    private

    def api_credentials_params
      params.require(:api_credential).permit(:encrypted_api_key, :integration_id)
    end
  end
end
