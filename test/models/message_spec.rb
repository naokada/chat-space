require 'rails_helper'

class MessageTest < ActiveSupport::TestCase
  describe Message do
    let(:group) {create(:create)}
    let(:user) {create(:user)}
    before do
      @group = user.groups.first
    end

    it "is valid with message with a body" do
      message = build(:message, image: nil, user_id: user.id, group_id: @group.id)
      message.valid?
      expect(message).to be_valid
    end

    it "is valid with message with an image" do
      message = build(:message, body: nil, user_id: user.id, group_id: @group.id)
      message.valid?
      expect(message).to be_valid
    end

    it "is valid with message with an image and a body" do
      message = build(:message, user_id: user.id, group_id: @group.id)
      message.valid?
      expect(message).to be_valid
    end

    it "is invalid with message without neither an image or a body" do
      message = build(:invalid_message, user_id: user.id, group_id: @group.id)
      message.valid?
      expect(message.errors[:body_or_image]).to include("を入力してください")
    end

    it "is invalid with message without user_id" do
      message = build(:message, user_id: nil, group_id: @group.id)
      message.valid?
      expect(message.errors[:user]).to include("を入力してください")
    end

    it "is invalid with message without group_id" do
      message = build(:message, user_id: user.id, group_id: nil)
      message.valid?
      expect(message.errors[:group]).to include("を入力してください")
    end
  end
end
