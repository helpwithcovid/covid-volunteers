class OffersController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_offer, only: [ :show, :edit, :update, :destroy ]
  before_action :ensure_owner_or_admin, only: [ :edit, :update, :destroy ]
  before_action :hide_global_announcements
  before_action :set_bg_white, only: [ :index ]

  def index
    @offers = Offer.all.order('created_at DESC').all
  end

  def show
  end

  def new
    @offer = Offer.new
  end

  def edit
  end

  def create
    @offer = Offer.new(offer_params)

    @offer.user = current_user

    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer, notice: I18n.t('offer_was_successfully_created') }
        format.json { render :show, status: :created, location: @offer }
      else
        format.html { render :new }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to @offer, notice: I18n.t('offer_was_successfully_updated') }
        format.json { render :show, status: :ok, location: @offer }
      else
        format.html { render :edit }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to offers_url, notice: I18n.t('offer_was_successfully_destroyed') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def offer_params
      params.fetch(:offer, {}).permit(:name, :description, :limitations, :redemption, :location)
    end

    def ensure_owner_or_admin
      if current_user != @offer.user && !current_user.is_admin?
        flash[:error] = I18n.t('apologies_you_don_t_have_access_to_this')
        redirect_to offers_path
      end
    end
end
