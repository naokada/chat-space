FactoryGirl.define do
  factory :message do
    body  Faker::Name.name
    image Rack::Test::UploadedFile.new(File.join(Rails.root, 'test/fixtures/files/sample.jpg'))
  end

  factory :invalid_message, class: "Message" do
    body  nil
    image nil
  end
end
