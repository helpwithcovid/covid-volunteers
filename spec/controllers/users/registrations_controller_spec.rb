require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  set_devise_mapping_to_user
  render_views

  describe 'GET #index' do
    let(:do_request) { get :index }

    shared_examples 'it displays volunteer' do
      it 'is successful' do
        expect(response).to be_successful
      end

      it 'displays volunteer' do
        expect(response.body).to include(user.name)
      end
    end

    shared_examples 'it does not display volunteer' do
      it 'is successful' do
        expect(response).to be_successful
      end

      it 'does not display volunteer' do
        expect(response.body).to_not include(user.name)
      end
    end

    context 'with one volunteer' do
      let!(:user) { create(:user_visible) }
      before(:all){ User.delete_all } # clean slate to avoid data pollution issue in CircleCI builds

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

        it_behaves_like 'it displays volunteer'

        context 'when skills are selected' do
          let(:do_request) { get :index, params: params }
          let(:params) { { skills: ['Analytics'] } }

          it_behaves_like 'it does not display volunteer'

          context 'when a user has matching skills' do
            let!(:user) { create(:user_visible, skill_list: ['Analytics']) }

            it_behaves_like 'it displays volunteer'
          end
        end

        context 'when a search term is provided' do
          let(:do_request) { get :index, params: params }
          let(:params) { { query: 'paris' } }

          it_behaves_like 'it does not display volunteer'

          context 'when a user has matching value' do
            let!(:user) { create(:user_visible, location: 'Paris') }

            it_behaves_like 'it displays volunteer'
          end
        end

        context 'when volunteer visibility is false' do
          let!(:user) { create(:user, visibility: false) }

          it_behaves_like 'it does not display volunteer'
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

          it_behaves_like 'it displays volunteer'
        end
      end

      context 'with a second volunteer' do
        let!(:user_two) { create(:user_visible, created_at: Date.tomorrow) }

        before { do_request }

        context 'if sort latest is selected' do
          let(:do_request) { get :index, params: params }
          let(:params) { { sort_by: 'latest' } }

          it 'is successful' do
            expect(response).to be_successful
          end

          it 'orders them from latest to earliest' do
            expect(assigns(:users).first).to eq(user_two)
            expect(assigns(:users).last).to eq(user)
          end
        end

        context 'if sort earliest is selected' do
          let(:do_request) { get :index, params: params }
          let(:params) { { sort_by: 'earliest' } }

          it 'is successful' do
            expect(response).to be_successful
          end

          it 'orders them from earliest to latest' do
            expect(assigns(:users).first).to eq(user)
            expect(assigns(:users).last).to eq(user_two)
          end
        end
      end
    end

    context 'with twenty-six volunteers' do
      before do
        25.times { create(:user_visible, name: 'Any Name') }
        create(:user_visible, name: 'Volunteer 26')

        do_request
      end

      context 'when first page is requested' do
        let(:do_request) { get :index, params: params }
        let(:params) { { page: 1 } }

        it 'is successful' do
          expect(response).to be_successful
        end

        it 'only returns the first twenty-five volunteers' do
          expect(response.body).to include('Any Name')
          expect(response.body).to_not include('Volunteer 26')
        end
      end

      context 'when second page is requested' do
        let(:do_request) { get :index, params: params }
        let(:params) { { page: 2 } }

        it 'is successful' do
          expect(response).to be_successful
        end

        it 'returns the twenty-sixth volunteer' do
          pending 'FIXME this test is broken; was functionality change or is test brittle?'

          expect(response.body).to_not include('Any Name')
          expect(response.body).to include('Volunteer 26')
        end
      end
    end
  end

  describe 'GET #show' do
    let(:subject) { get :show, params: { id: user.id } }

    context 'when a volunteer exists' do
      let(:user) { build(:user, id: 9999) }

      before { allow(User).to receive(:where).and_return([user]) }

      context 'when user can view volunteer' do
        before { allow(user).to receive(:is_visible_to_user?).and_return(true) }

        it { is_expected.to be_successful }

        it { expect(subject.body).to have_content(user.name) }
      end

      context 'when a user cannot view volunteer' do
        before { allow(user).to receive(:is_visible_to_user?).and_return(false) }

        it { is_expected.to_not be_successful }

        it { is_expected.to redirect_to(projects_path) }

        it 'displays flash error' do
          subject

          expect(flash[:error]).to eq('Sorry, no such user.')
        end
      end
    end

    context 'when volunteer does not exist' do
      let(:user) { double(id: 9999)}

      it { is_expected.to_not be_successful }

      it { is_expected.to redirect_to(projects_path) }

      it 'displays flash error' do
        subject

        expect(flash[:error]).to eq('Sorry, no such user.')
      end
    end
  end

  describe 'GET #new' do
    it 'tracks an event' do
      # The line below doesn't work since the GET request sets and deletes the variable within same request:
      # expect(session[:track_event]).to eq('Project creation started')
      expect(controller).to receive(:track_event).with('User registration started')

      get :new
    end

    it 'is successful' do
      get :new

      expect(response).to be_successful
    end

    it 'displays form' do
      get :new

      expect(response.body).to include('Sign up for an account')
    end
  end

  describe 'POST #create' do
    let(:params) { { user: { email: 'test@gmail.com', password: 'test123', password_confirmation: 'test123' } } }

    context 'when email does not already exist' do
      it 'tracks an event' do
        # The line below doesn't work since the GET request sets and deletes the variable within same request:
        # expect(session[:track_event]).to eq('Project creation started')
        expect(controller).to receive(:track_event).with('User registration complete')

        post :create, params: params
      end

      it 'redirects to the projects page' do
        post :create, params: params

        expect(response).to redirect_to projects_path
      end

      it 'adds user to db' do
        expect { post :create, params: params }.to change(User, :count).by(1)
      end
    end

    context 'when email already exists' do
      before { create(:user, email: 'test@gmail.com') }

      it 'does not track an event' do
        expect(controller).to_not receive(:track_event).with('User registration complete')

        post :create, params: params
      end

      it 'it re-renders the form' do
        post :create, params: params

        expect(response).to render_template :new
        expect(response.body).to include('Email has already been taken')
      end

      it 'does not add user to db' do
        expect { post :create, params: params }.to_not change(User, :count)
      end
    end
  end

  describe 'PUT #update' do
    let!(:user) { create(:user_complete_profile) }
    let(:params) { { user: { id: user.id, email: 'changed@gmail.com' } } }

    before do
      sign_in user
      session[:return_to] = projects_path
    end

    it 'we should be on projects path' do
      put :update, params: params
      
      user.reload
      expect(user.email).to eq('changed@gmail.com')
    end

    it 'should redirect to return_to cookie path' do
      put :update, params: params

      expect(response).to redirect_to projects_path
    end

  end
end
