require 'rails_helper'

RSpec.describe BusinessesController, type: :controller do
  render_views

  describe 'GET #new' do
    context 'when user is signed out' do

      it 'is unsuccessful' do
        get :new

        expect(response).to_not be_successful
      end
    end

    context 'when user is signed in' do
      let(:user) { create(:user) }
      before { sign_in user }

      it 'is successful' do
        get :new

        expect(response).to be_successful
        expect(response.body).to include('Create new business')
      end
    end
  end

  describe 'POST #create' do
    context 'when user is signed out' do

      it 'is unsuccessful' do
        post :create

        expect(response).to_not be_successful
      end
    end

    context 'when user is signed in' do
      let(:user) { create(:user) }

      before { sign_in user }

      context 'when business is invalid' do
        let(:invalid_params) { { business: attributes_for(:business, :invalid) } }

        it 'render new template' do
          post :create, params: invalid_params

          expect(response).to render_template(:new)
          expect(flash[:error]).to eq('Error creating business') 
        end

        it 'does not add a business to the database' do
          expect { post :create, params: invalid_params }.to_not change(Business, :count)
        end
      end

      context 'when business is valid' do
        let(:valid_params) { { business: attributes_for(:business) } }

        it 'is successful' do
          post :create, params: valid_params

          expect(response).to redirect_to(Business.last)
          expect(flash[:notice]).to eq('Business was successfully created.') 
        end

        it 'adds a business to the database' do
          expect { post :create, params: valid_params }.to change(Business, :count).by(1)
        end
      end
    end    
  end

  describe 'GET #show' do
    let(:business) { create(:business) }
    let(:params) { { id: business.id } }

    context 'when user is signed out' do
      it 'is unsuccessful' do
        get :show, params: params

        expect(response).to_not be_successful
      end
    end

    context 'when user is signed in' do
      let(:user) { create(:user) }

      it 'is successful' do
        sign_in user

        get :show, params: params

        expect(response).to be_successful
        expect(response.body).to include(business.name)
        expect(response.body).to include(business.link)
        expect(response.body).to include(business.description)
      end
    end
  end
end
