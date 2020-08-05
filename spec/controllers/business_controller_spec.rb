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

      it 'is successful' do
        sign_in user

        get :new

        expect(response).to be_successful
        expect(response.body).to include('Create new business')
      end
    end
  end
end
