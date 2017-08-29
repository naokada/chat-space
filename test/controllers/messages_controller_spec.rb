require 'rails_helper'

class MessagesControllerTest < ActionController::TestCase
  describe MessagesController, type: :controller do
    let(:user) { create(:user) }
    let(:group) { create(:group) }
    let(:message) { create(:message) }
    let(:invalid_message) { create(:invalid_message) }

    describe 'GET #new', type: :controller do
      context 'when user signed_in' do
        before do
          login_user user
          @group = user.groups.first
          get :new, params:{group_id: @group.id}
        end

        it 'assigns the requested new message @message' do
          expect(assigns(:message)).to be_a_new(Message)
        end

        it 'assigns the requested messages @messages' do
          messages = group.messages
          expect(assigns(:messages)).to eq messages
        end

        it 'renders the :new template' do
          expect(response).to render_template :new
        end
      end
    end

    describe 'POST #create', type: :controller do

      context 'when user sign_in and succeed to save' do
        before do
          login_user user
          @group = user.groups.first
        end

        it 'saves a new message' do
          expect{
            post :create, params:{ message: attributes_for(:message), group_id: @group.id }
          }.to change(Message, :count).by(1)
        end

        it 'redirect_to new message page' do
          post :create, params:{ message: attributes_for(:message), group_id: @group.id }
          expect(response).to redirect_to new_group_message_path(@group.id)
        end
      end

     context 'when user sign_in and does not succeed to save' do
        before do
          login_user user
          @group = user.groups.first
        end

        it 'saves a new message' do
          expect{
            post :create, params:{ message: attributes_for(:invalid_message), group_id: @group.id }
          }.not_to change(Message, :count)
        end

        it 're-render the :new template' do
          post :create, params:{ message: attributes_for(:invalid_message), group_id: @group.id }
          expect(response).to render_template :new
        end
      end

      context 'when user not signed_in' do
        before do
          @group = user.groups.first
        end

        it 'requires login' do
          post :create, params:{ message: attributes_for(:message), group_id: @group.id }
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end
end
