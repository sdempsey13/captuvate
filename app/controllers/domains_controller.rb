class DomainsController < ApplicationController
  before_action :set_domain, only: %i[ show show_desktop show_mobile edit update destroy ]
  before_action :set_domains, only: %i[ index show show_desktop show_mobile ]

  def index
  end

  def show
    authorize @domain
  end

  def show_desktop
    @snap_shots = SnapShot.for_domain_desktop(@domain)
    authorize @domain
  end

  def show_mobile
    @snap_shots = SnapShot.for_domain_mobile(@domain)
    authorize @domain
  end

  def new
    @domain = Domain.new
    @domain.build_domain_schedule
  end

  def edit
    authorize @domain
  end

  def create
    @domain = Domain.new(domain_params)

    respond_to do |format|
      if @domain.save
        format.html { redirect_to domain_path_generator(@domain), notice: "Domain was successfully created." }
        format.json { render :show, status: :created, location: @domain }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @domain
    respond_to do |format|
      if @domain.update(domain_params)
        format.html { redirect_to domain_path_generator(@domain), notice: "Domain was successfully updated." }
        format.json { render :show, status: :ok, location: @domain }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @domain
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

  def set_domains
    @domains = current_user.domains
  end

  def domain_params
    params.expect(domain: [ :user_id, :url, :name, :collects_desktop, :collects_mobile, domain_schedule_attributes: [:frequency] ])
  end
end
