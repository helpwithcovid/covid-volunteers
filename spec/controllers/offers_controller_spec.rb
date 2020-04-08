require 'rails_helper'

RSpec.describe OffersController, type: :controller do

  describe 'GET #index' do
    it 'works' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it 'works' do
      pending 'TODO'
      fail
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
