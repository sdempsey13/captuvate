module Settings
  class WebhookCredentialsController < ApplicationController
    
    def index
      @webhook_credentials = current_organization.webhook_credentials
      @webhook_credential = WebhookCredential.new
    end

    def create
      @webhook_credential = current_organization.webhook_credentials.build(webhook_credentials_params)
      @webhook_credential.organization_id = current_organization.id

      if @webhook_credential.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to settings_webhooks_path, notice: 'Webhook stored successfully' }
        end
      else
        @webhook_credentials = current_organization.webhook_credentials
    
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace(
              "webhook_credential_form",
              partial: "settings/webhook_credentials/form",
              locals: { webhook_credential: @webhook_credential }
            )
          end
    
          format.html { render :index, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @webhook_credential = WebhookCredential.find(params[:id])
      @webhook_credential.destroy

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to settings_webhooks_path, notice: "API deleted"}
      end
    end

    private

    def webhook_credentials_params
      params.require(:webhook_credential).permit(:encrypted_secret_key, :integration_id)
    end

  end
end
