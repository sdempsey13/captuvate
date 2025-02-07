class PageGroupsController < ApplicationController
  before_action :set_page_group, only: %i[ show ]
  before_action :authenticate_user!

  def show
    binding.pry
    @pages = current_user.pages
    @page_group_pages = @page_group.pages
  end

  private
  def set_page_group
    @page_group = PageGroup.find(params.expect(:id))
  end
end