class SnapShotsController < ApplicationController
  before_action :set_snap_shot, only: %i[ show show_html ]
  before_action :authenticate_user!

  def show
    @domains = current_user.domains
    @comments = @snap_shot.comments.reverse_order
  end

  def create
    SnapShotJob.perform_later(Domain.find(params[:id]))
  end

  def show_html
    html_blob = @snap_shot.html_file

    # Stream the file with explicit inline disposition and content type
    response.headers['Content-Disposition'] = "inline; filename=\"#{html_blob.filename}\""
    response.headers['Content-Type'] = html_blob.content_type

    # Stream the file body
    send_data html_blob.download, disposition: 'inline', filename: html_blob.filename.to_s
  end

  private
  def set_snap_shot
    @snap_shot = SnapShot.find(params.expect(:id))
  end
end