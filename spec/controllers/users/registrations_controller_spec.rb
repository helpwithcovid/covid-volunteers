require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  set_devise_mapping_to_user

  describe 'GET #index' do
    before { get :index }

    context 'with a volunteer' do
      it 'assigns filters open variable' do
      end

      it 'shows/assigns search bar' do
      end

      it 'shows/assigns sorting options' do
      end

      it 'shows/assigns filters' do
      end

      it 'is successful' do
      end

      it 'returns all the volunteers' do
      end

      context 'when skills are selected' do

        it 'returns no volunteers' do
        end
        context 'when a user has matching skills' do
          it 'returns the volunteer' do
          end
        end

      end

      context 'when a search term is provided' do
        it 'returns no volunteers' do
        end

        context 'when a user has matching value' do
          it 'returns the volunteer' do
          end
        end
      end

      context 'when volunteer visibility is false' do
        context 'when user is not admin' do
          it 'does not return user' do
          end
        end

        context 'when user is admin' do
          it 'returns user' do
          end
        end
      end
    end

    context 'with more than one volunteer' do
      it 'orders them' do
      end
    end

    context 'with 26 volunteers' do
      context 'when first page is accessed' do
        it 'returns the first 25 volunteers' do
        end
      end

      context 'when second page is accessed' do
        it 'returns the 26th volunteer' do
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
