require 'rails_helper'

RSpec.describe OffersController, type: :controller do
  render_views

  shared_examples 'it does not show global announcements' do
    it 'does not show global announcements' do
      expect(response).to_not render_template(:partial => '_global-announcements')
    end
  end

  shared_examples 'an unsuccessful request' do
    it 'is unsuccessful' do
      expect(response).not_to be_successful
    end 
  end

  shared_examples 'a successful request' do |text|
    it 'is successful' do
      expect(response).to be_successful
    end

    it 'renders the correct page' do
      expect(response.body).to include(text)
    end
  end
  
  describe 'GET #index' do
    let!(:offer) { create(:offer, name: 'Free books', user: user) }
    let(:user) { create(:user) }
    
    before { get :index }
    
    it_behaves_like 'a successful request', 'Free books'

    it 'assigns offers' do
      expect(assigns(:offers)).to eq([offer])
    end

    it_behaves_like 'it does not show global announcements'
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    let!(:offer) { create(:offer, name: 'Free coffee', user: user) }

    before { get :show, params: { id: offer_id } }

    context 'with a numeric id as param' do
      let(:offer_id) { offer.id } 
      
      it_behaves_like 'a successful request', 'Free coffee'

      it 'assigns the offer' do
        expect(assigns(:offer)).to eq(offer)
      end
      
      it_behaves_like 'it does not show global announcements'
    end

    context 'with a parameterized id' do 
      let(:offer_id) { offer.to_param }
      
      it_behaves_like 'a successful request', 'Free coffee'

      it 'assigns the offer' do
        expect(assigns(:offer)).to eq(offer)
      end
      
      it_behaves_like 'it does not show global announcements'
    end
  end

  describe 'GET #new' do
    let(:user) { create(:user) }

    context 'when user is not signed in' do
      before { get :new }

      it_behaves_like 'an unsuccessful request'
    end

    context 'when user is signed-in' do
      before do 
        sign_in user

        get :new
      end

      it_behaves_like 'a successful request', 'Create new resource'

      it 'assigns an offer' do
        expect(assigns(:offer)).to be_an_instance_of(Offer)
      end

      it_behaves_like 'it does not show global announcements'
    end
  end

  describe 'GET #edit' do
    let(:offer) { create(:offer, user: user) }
    let(:user) { create(:user) }

    context 'when user is not signed in' do
      before { get :edit, params: { id: offer.id } }

      it_behaves_like 'an unsuccessful request'
    end

    context 'when user is signed-in' do
      before do
        sign_in user

        get :edit, params: { id: offer.id }
      end

      it_behaves_like 'a successful request', 'Edit resource'

      it 'assigns the offer' do
        expect(assigns(:offer)).to eq(offer)
      end

      it_behaves_like 'it does not show global announcements'
    end

    context 'when admin is signed-in' do
      let (:admin) { create(:user, email: ADMINS[0]) }

      before do
        sign_in admin

        get :edit, params: { id: offer.id }
      end

      it_behaves_like 'a successful request', 'Edit resource'

      it 'assigns the offer' do
        expect(assigns(:offer)).to eq(offer)
      end
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'when user is not signed in' do
      before { post :create }

      it_behaves_like 'an unsuccessful request'
    end

    context 'when user is signed-in' do
      before { sign_in user }

      context 'when offer cannot be saved' do
        let(:offer) { build(:offer) }
        
        before do 
          allow(Offer).to receive(:new).and_return(offer)
          allow(offer).to receive(:save).and_return(false)

          post :create
        end

        it 'is unsuccessful' do
          expect(response).to render_template(:new)
        end
      end

      context 'when offer can be saved' do
        before { post :create }

        it 'is successful' do
          expect(response).to redirect_to(offer_path(assigns(:offer)))
          expect(flash[:notice]).to eq('Offer was successfully created.')
        end

        it_behaves_like 'it does not show global announcements'
      end
    end
  end

  describe 'PUT #update' do
    let(:user) { create(:user) }
    let(:offer) { create(:offer, user: user) }
    let(:params) { { id: offer.id, name: 'a new name' } }

    context 'when user is not signed in' do
      before { put :update, params: params }

      it_behaves_like 'an unsuccessful request'    
    end

    context 'when user is signed in' do
      before { sign_in user }

      context 'when offer cannot be updated' do
        before do
          allow(Offer).to receive(:find).and_return(offer)
          allow(offer).to receive(:update).and_return(false)

          put :update, params: params
        end

        it 'is unsuccessful' do
          expect(response).to render_template(:edit)
        end
      end

      context 'when offer can be updated' do
        before { put :update, params: params }

        it 'is successful' do
          expect(response).to redirect_to(offer_path(offer))
          expect(flash[:notice]).to eq('Offer was successfully updated.')
        end

        it_behaves_like 'it does not show global announcements'
      end
    end

    context 'when admin is signed in' do
      let (:admin) { create(:user, email: ADMINS[0]) }

      before do
        sign_in admin
        put :update, params: { id: offer.id, name: 'a new name' }
      end

      it 'it is successful' do
        expect(response).to redirect_to(offer_path(offer))
      end
    end    
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let(:offer) { create(:offer, user: user) }

    context 'when user is not signed in' do
      before { post :destroy, params: { id: offer.id } }

      it_behaves_like 'an unsuccessful request'     
    end

    context 'when user is signed-in' do
      before do
        sign_in user
        post :destroy, params: { id: offer.id }
      end
      it 'is successful' do
        expect(response).to redirect_to(offers_path)
        expect(flash[:notice]).to eq('Offer was successfully destroyed.')
      end

      it_behaves_like 'it does not show global announcements'
    end

    context 'when admin is signed in' do
      let (:admin) { create(:user, email: ADMINS[0]) }

      before do
        sign_in admin
        post :destroy, params: { id: offer.id }
      end

      it 'is successful' do
        expect(response).to redirect_to(offers_path)
      end
    end
  end
end
