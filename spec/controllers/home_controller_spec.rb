require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:project) { FactoryBot.create(:project, user: user) }

  describe '#index' do
    it 'works' do
      get :index
      expect(response).to be_successful
    end

    it 'works when signed in' do
      sign_in(user)
      expect(response).to be_successful
    end
  end

end
