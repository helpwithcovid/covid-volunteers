require 'rails_helper'

RSpec.describe OffersController, type: :controller do

  describe 'GET #index' do
    it 'works' do
      pending 'TODO'
      fail
    end
  end

  describe 'GET #show' do
    let!(:user){ FactoryBot.create(:user) }
    let!(:offer){ FactoryBot.create(:offer, user: user) }

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
    it 'works' do
      pending 'TODO'
      fail
    end
  end

  describe 'GET #edit' do
    it 'works' do
      pending 'TODO'
      fail
    end
  end

  describe 'POST #create' do
    it 'works' do
      pending 'TODO'
      fail
    end
  end

  describe 'PUT #update' do
    it 'works' do
      pending 'TODO'
      fail
    end
  end


  describe 'DELETE #destroy' do
    it 'works' do
      pending 'TODO'
      fail
    end
  end

end
