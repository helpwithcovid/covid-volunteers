require 'rails_helper'

RSpec.describe OffersController, type: :controller do
  render_views

  describe 'GET #index' do
    let!(:offer) { create(:offer, name: 'Free books', user: user) }
    let(:user) { create(:user) }
    
    before { get :index }
    
    it 'is successful' do
      expect(response).to be_successful
    end

    it 'assigns offers' do
      expect(assigns(:offers)).to eq([offer])
    end

    it 'renders the offer' do
      expect(response.body).to include('Free books')
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    let!(:offer) { create(:offer, user: user) }

    it 'works with just a numeric id as param' do
      get :show, params: { id: offer.id }
      expect(response).to be_successful
      expect(assigns(:offer)).to eq(offer)
    end

    it 'works with a "5-my-offer-name" param too' do
      expect(offer.to_param).to eq("#{offer.id}-#{offer.name.parameterize}")
      get :show, params: { id: offer.to_param }
      expect(response).to be_successful
      expect(assigns(:offer)).to eq(offer)
    end
  end

  describe 'GET #new' do
    let(:user) { create(:user) }

    it 'is successful' do
      
      sign_in user

      get :new

      expect(response).to be_successful
    end

    it 'assigns an offer' do
      sign_in user

      get :new

      expect(assigns(:offer)).to be_an_instance_of(Offer)
    end

    it 'renders form for creating an offer' do
      sign_in user

      get :new 
      
      expect(response.body).to include('Create new resource')     
    end
  end

  describe 'GET #edit' do
    let(:offer) { create(:offer, user: user) }
    let(:user) { create(:user) }

    it 'is successful' do
      
      sign_in user

      get :edit, params: { id: offer.id }

      expect(response).to be_successful
    end

    it 'assigns the offer' do
      sign_in user

      get :edit, params: { id: offer.id }

      expect(assigns(:offer)).to eq(offer)
    end

    it 'renders form for creating an offer' do
      sign_in user

      get :edit, params: { id: offer.id  }
      
      expect(response.body).to include("Edit resource #{offer.name}")     
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    it 'works' do
      sign_in user
      post :create, params: { offer: { name: 'name', description: 'desc', limitations: 'limit', redemption: 'red', location: 'loc'} }

      expect(response).to redirect_to(offer_path(assigns(:offer))) #Can't think of a better wato test this...
    end
  end

  describe 'PUT #update' do
    let(:user) { create(:user) }
    let(:offer) { create(:offer, user: user) }

    it 'works' do
      sign_in user
      put :update, params: { id: offer.id, name: 'a new name' }

      expect(response).to redirect_to(offer_path(offer))
    end
  end


  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:offer) { create(:offer, user: user) }

    it 'works' do
      sign_in user
      post :destroy, params: { id: offer.id }

      expect(response).to redirect_to(offers_path)
    end
  end
end
