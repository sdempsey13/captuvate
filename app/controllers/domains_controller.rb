class DomainsController < ApplicationController
  before_action :set_domain, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def index
    @domains = current_user.domains
  end

  def show
    @domain = current_user.domains.find(params[:id])
    @domains = current_user.domains
  end

  def new
    @domain = Domain.new
    @domain.build_domain_schedule
  end

  def edit
  end

  def create
    @domain = Domain.new(domain_params)

    respond_to do |format|
      if @domain.save
        format.html { redirect_to @domain, notice: "Domain was successfully created." }
        format.json { render :show, status: :created, location: @domain }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @domain.update(domain_params)
        format.html { redirect_to @domain, notice: "Domain was successfully updated." }
        format.json { render :show, status: :ok, location: @domain }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @domain.destroy!

    respond_to do |format|
      format.html { redirect_to domains_path, status: :see_other, notice: "Domain was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_domain
    @domain = Domain.find(params.expect(:id))
  end

  def domain_params
    params.expect(domain: [ :user_id, :url, domain_schedule_attributes: [:frequency] ])
  end
end
