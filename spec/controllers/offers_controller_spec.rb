require 'rails_helper'

RSpec.describe OffersController, type: :controller do
  render_views

  shared_examples 'it does not show global announcements' do
    it 'does not show global announcements' do
      expect(response).to_not render_template(:partial => '_global-announcements')
    end
  end
  
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

    it 'renders offers' do
      expect(response.body).to include('Free books')
    end

    it_behaves_like 'it does not show global announcements'
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    let!(:offer) { create(:offer, name: 'Free coffee', user: user) }

    shared_examples 'it successfully completes the #show action' do
      before { get :show, params: { id: offer_id } }

      it 'is successful' do
        expect(response).to be_successful
      end
      
      it 'assigns the offer' do
        expect(assigns(:offer)).to eq(offer)
      end

      it 'renders the offer' do
        expect(response.body).to include('Free coffee')
      end 
      
      it_behaves_like 'it does not show global announcements'
    end

    context 'with a numeric id as param' do
      let(:offer_id) { offer.id } 
      
      it_behaves_like 'it successfully completes the #show action'
    end

    context 'with a parameterize id' do 
      let(:offer_id) { offer.to_param }
      
      it_behaves_like 'it successfully completes the #show action'
    end
  end

  describe 'GET #new' do
    let(:user) { create(:user) }

    context 'when user is not signed in' do
      before { get :new }

      it 'is unsuccessful' do
        expect(response).not_to be_successful
      end      
    end

    context 'when user is signed-in' do
      before do 
        sign_in user

        get :new
      end

      it 'is successful' do
        expect(response).to be_successful
      end

      it 'assigns an offer' do
        expect(assigns(:offer)).to be_an_instance_of(Offer)
      end

      it 'renders form for creating an offer' do
        expect(response.body).to include('Create new resource')     
      end

      it_behaves_like 'it does not show global announcements'
    end
  end

  describe 'GET #edit' do #TEST ONLY OWNER OR ADMIN, 
    let(:offer) { create(:offer, user: user) }
    let(:user) { create(:user) }

    context 'when user is not signed in' do
      before { get :edit, params: { id: offer.id } }

      it 'is unsuccessful' do
        expect(response).not_to be_successful
      end      
    end

    context 'when user is signed-in' do
      before do
        sign_in user

        get :edit, params: { id: offer.id }
      end

      it 'is successful' do
        expect(response).to be_successful
      end

      it 'assigns the offer' do
        expect(assigns(:offer)).to eq(offer)
      end

      it 'renders form for creating an offer' do
        expect(response.body).to include("Edit resource #{offer.name}")     
      end

      it_behaves_like 'it does not show global announcements'
    end

    context 'when admin is signed-in' do
      let (:admin) { create(:user, email: ADMINS[0]) }

      before do
        sign_in admin

        get :edit, params: { id: offer.id }
      end

      it 'is successful' do
        expect(response).to be_successful
      end

      it 'assigns the offer' do
        expect(assigns(:offer)).to eq(offer)
      end

      it 'renders form for creating an offer' do
        expect(response.body).to include("Edit resource #{offer.name}")     
      end

      it_behaves_like 'it does not show global announcements'
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'when user is not signed in' do
      before { post :create, params: { offer: { name: 'name', description: 'desc', limitations: 'limit', redemption: 'red', location: 'loc'} } }

      it 'is unsuccessful' do
        expect(response).not_to be_successful
      end      
    end

    context 'when user is signed-in' do
      before do
        sign_in user
        post :create, params: { offer: { name: 'name', description: 'desc', limitations: 'limit', redemption: 'red', location: 'loc'} }
      end

      it 'redirects to the offer' do
        expect(response).to redirect_to(offer_path(assigns(:offer))) #Can't think of a better wato test this...
      end
    end

    it_behaves_like 'it does not show global announcements'
  end

  describe 'PUT #update' do
    let(:user) { create(:user) }
    let(:offer) { create(:offer, user: user) }

    context 'when user is not signed in' do
      before { put :update, params: { id: offer.id, name: 'a new name' } }

      it 'is unsuccessful' do
        expect(response).not_to be_successful
      end      
    end

    context 'when user is signed in' do
      before do
        sign_in user
        put :update, params: { id: offer.id, name: 'a new name' }
      end

      it 'redirects to the offer' do
        expect(response).to redirect_to(offer_path(offer))
      end

      it_behaves_like 'it does not show global announcements'
    end

    context 'when admin is signed in' do
      let (:admin) { create(:user, email: ADMINS[0]) }

      before do
        sign_in admin
        put :update, params: { id: offer.id, name: 'a new name' }
      end

      it 'redirects to the offer' do
        expect(response).to redirect_to(offer_path(offer))
      end
    end    
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:offer) { create(:offer, user: user) }

    context 'when user is not signed in' do
      before { post :destroy, params: { id: offer.id } }

      it 'is unsuccessful' do
        expect(response).not_to be_successful
      end      
    end

    context 'when user is signed-in' do
      before do
        sign_in user
        post :destroy, params: { id: offer.id }
      end
      it 'it redirects to the offers' do
        expect(response).to redirect_to(offers_path)
      end

      it_behaves_like 'it does not show global announcements'
    end

    context 'when admin is signed in' do
      let (:admin) { create(:user, email: ADMINS[0]) }

      before do
        sign_in admin
        post :destroy, params: { id: offer.id }
      end

      it 'redirects to the offer' do
        expect(response).to redirect_to(offers_path)
      end
    end
  end
end
