require 'rails_helper'

class MessageTest < ActiveSupport::TestCase
  describe Message do
    let(:group) { create(:create) }
    let(:user) { create(:user) }
    before do
      @group = user.groups.first
    end
    let(:message) do
      message = build(:message, body: body, image: image, user_id: user_id, group_id: group_id)
    end

    context "has group_id and user_id" do
    let(:body) { nil }
    let(:image) { nil }
    let(:user_id) { user.id }
    let(:group_id) { @group.id }

      context "has body" do
        let(:body) { Faker::Lorem.sentence }

        it "is valid with message with a body" do
          message.valid?
          expect(message).to be_valid
        end
      end

      context "has image" do
        let(:image) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'test/fixtures/files/sample.jpg')) }

        it "is valid with message with an image" do
          message.valid?
          expect(message).to be_valid
        end
      end

      context "has both body and image" do
        let(:body) { Faker::Lorem.sentence }
        let(:image) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'test/fixtures/files/sample.jpg')) }

        it "is valid with message with an image and a body" do
          message.valid?
          expect(message).to be_valid
        end
      end
    end

    context "does not have a nessary factor" do
      let(:body) { Faker::Lorem.sentence }
      let(:image) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'test/fixtures/files/sample.jpg')) }
      let(:user_id) { user.id }
      let(:group_id) { @group.id }

      context "does not have neither an image or a body" do
        let(:body) { nil }
        let(:image) { nil }

        it "is invalid with message without neither an image or a body" do
          message.valid?
          expect(message.errors[:body_or_image]).to include("を入力してください")
        end
      end

      context "does not have neither an user_id" do
        let(:user_id) { nil }

        it "is invalid with message without user_id" do
          message.valid?
          expect(message.errors[:user]).to include("を入力してください")
        end
      end

      context "does not have neither an user_id" do
        let(:group_id) { nil }

        it "is invalid with message without group_id" do
          message.valid?
          expect(message.errors[:group]).to include("を入力してください")
        end
      end
    end
  end
end
