class OffersController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_offer, only: [ :show, :edit, :update, :destroy ]
  before_action :ensure_owner_or_admin, only: [ :edit, :update, :destroy ]
  before_action :set_offers_announcements
  before_action :remove_global_announcements

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
        format.html { redirect_to @offer, notice: 'Offer was successfully created.' }
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
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
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
      format.html { redirect_to offers_url, notice: 'Offer was successfully destroyed.' }
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
        flash[:error] = "Apologies, you don't have access to this."
        redirect_to offers_path
      end
    end

    def set_offers_announcements
      @offers_announcements = [
        {
          title: 'HWC Volunteer Playbook',
          sub_title: 'A short guide created by our team to help you successfully manager your project and volunteers!',
          cta_text: 'Download playbook',
          cta_url: 'https://docs.google.com/document/d/1f_-g893NGawa5n4KyDw6zjrocO2VBS5b2siQIZ6csY0/view'
        },
        {
          title: 'Webinar on How to Scale Volunteers',
          sub_title: 'Glen Moriarty, founder of 7cups on how he manages 320k volunteers.',
          cta_text: 'View recording',
          cta_url: 'https://openai.zoom.us/rec/play/vZN-dbuq-m03TNKSsASDAfEtW466J6qs1XQWrvtYxRvmU3QDNVv0NLJGYbffjdiMo1gf68qHVnbe2mOi?continueMode=true'
        }
      ]
    end
end
