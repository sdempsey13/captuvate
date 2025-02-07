class PagesController < ApplicationController
  before_action :set_page, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def index
    @pages = current_user.pages
  end

  def show
    
    # all pages joined to this one through their page_group
  end

  def new
    @page = Page.new
  end

  def edit
  end

  def create
    @page = Page.new(page_params)

    page_group = PageGroup.new
    page_group.save!

    @page.page_group_id = page_group.id

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: "Page was successfully created." }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1 or /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: "Page was successfully updated." }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1 or /pages/1.json
  def destroy
    @page.destroy!

    respond_to do |format|
      format.html { redirect_to pages_path, status: :see_other, notice: "Page was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params.expect(page: [ :user_id, :url ])
    end
end
