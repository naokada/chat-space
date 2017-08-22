require 'rails_helper'

class GroupsControllerTest < ActionController::TestCase
  describe GroupsController, type: :controller do
    let(:user) { create(:user) }

    describe 'GET #index', type: :controller do
      context 'when user signed_in' do
        before do
          login_user user
        end

        it 'assigns the repuested current_user.groups @groups' do
          get :index
          groups = user.groups
          expect(assigns(:groups)).to eq groups
        end

        it 'renders the :index template' do
          get :index
          expect(response).to render_template :index
        end
      end

      context 'when user not signed_in' do
        it 'requires login' do
          get :index
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end
end
