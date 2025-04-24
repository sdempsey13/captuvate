module Admin
  class DomainUploaderController < BaseController
    before_action :authorize_admin

    def new
    end

    def create
      uploaded_file = params[:csv_file]
      user_id = params[:user_id]

      if uploaded_file&.content_type == "text/csv"
        blob = ActiveStorage::Blob.create_and_upload!(
          io: uploaded_file,
          filename: uploaded_file.original_filename,
          content_type: uploaded_file.content_type
        )
        
       DomainUploadJob.perform_later(blob.id, user_id.to_i)
        
        flash[:notice] = "CSV file accepted!"
      else
        flash[:alert] = "Please upload a valid CSV file."
      end
      
      redirect_to new_admin_domain_uploader_path
    end

    private

    def authorize_admin
      authorize [:admin, :domain_uploader]
    end
  end
end