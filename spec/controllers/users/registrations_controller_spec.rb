require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  set_devise_mapping_to_user

  describe 'GET #index' do
    let(:do_request) { get :index }
    let!(:user) { create(:user_visible) }

    shared_examples 'it assigns volunteer' do
      it 'assigns volunteer' do
        expect(assigns(:users)).to eq([ user ])
      end
    end

    shared_examples 'it does not assign volunteer' do
      it 'does not assign volunteer' do
        expect(assigns(:users)).to eq([])
      end
    end
    
    context 'with no sign-in' do
      before { do_request }

      it 'shows/assigns search bar' do
        expect(assigns(:show_search_bar)).to eq(true)
      end

      it 'shows/assigns sorting options' do
        expect(assigns(:show_sorting_options)).to eq(true)
      end

      it 'shows/assigns filters' do
        expect(assigns(:show_filters)).to eq(true)
      end

      it 'is successful' do
        expect(response).to be_successful
      end
        
      it_behaves_like 'it assigns volunteer'

      context 'when skills are selected' do
        let(:do_request) { get :index, params: params }
        let(:params) { { skills: ['Analytics'] } }
            
        it_behaves_like 'it does not assign volunteer'

        context 'when a user has matching skills' do
          let!(:user) { create(:user_visible, skill_list: ['Analytics']) }

          it_behaves_like 'it assigns volunteer'
        end
      end

      context 'when a search term is provided' do
        let(:do_request) { get :index, params: params }
        let(:params) { { query: 'paris' } }

        it_behaves_like 'it does not assign volunteer'

        context 'when a user has matching value' do
          let!(:user) { create(:user_visible, location: 'Paris') }
          
          it_behaves_like 'it assigns volunteer'
        end
      end

      context 'when volunteer visibility is false' do
        let!(:user) { create(:user, visibility: false) }
          
        it_behaves_like 'it does not assign volunteer'
      end

      context 'with two volunteers' do
        let!(:user) { create(:user_visible, created_at: Date.parse('01/01/2020')) }
        let!(:user_two) { create(:user_visible, created_at: Date.parse('31/01/2020')) }

        context 'if sort latest is selected' do
          let(:do_request) { get :index, params: params }
          let(:params) { { sort_by: 'latest' } }

          it 'orders them from latest to earliest' do
            expect(assigns(:users).first).to eq(user_two)
            expect(assigns(:users).last).to eq(user)
          end
        end

        context 'if sort earliest is selected' do
          let(:do_request) { get :index, params: params }
          let(:params) { { sort_by: 'earliest' } }

          it 'orders them from earliest to latest' do
            expect(assigns(:users).first).to eq(user)
            expect(assigns(:users).last).to eq(user_two)
          end 
        end
      end 
    end

    context 'when admin is signed-in' do
      let (:admin) { create(:user, email: ADMINS[0]) }

      before do
        sign_in admin

        do_request
      end

      context 'when volunteer visibility is false' do
        let!(:user) { create(:user, visibility: false) }
          
        it 'returns volunteer' do
          expect(assigns(:users)).to include(user)
        end
      end      
    end

    context 'with twenty-six volunteers' do
      before do
        25.times { create(:user, visibility:true) }

        do_request
      end

      context 'when first page is requested' do
        let(:do_request) { get :index, params: params }
        let(:params) { { page: 1 } }

        it 'returns the first twenty-five volunteers' do
          last_user = User.last

          expect(assigns(:users).size).to eq(25)
          expect(assigns(:users)).to_not include(last_user)
        end
      end

      context 'when second page is requested' do
        let(:do_request) { get :index, params: params }
        let(:params) { { page: 2 } }

        it 'returns the twenty-sixth volunteer' do
          last_user = User.last

          expect(assigns(:users).size).to eq(1)
          expect(assigns(:users)).to include(last_user)
        end
      end
    end  
  end

  describe 'GET #show' do
    it 'works' do
      pending 'TODO'
      fail
    end
  end

  describe 'GET #new' do
    it 'tracks an event' do
      pending 'TODO'
      fail
    end
  end

  describe 'POST #create' do
    it 'tracks an event' do
      pending 'TODO'
      fail
    end
  end
end
