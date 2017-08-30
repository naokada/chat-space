FactoryGirl.define do
  factory :message do
    body    Faker::Name.name
    image   Faker::File.file_name
  end

  factory :invalid_message, class: "Message" do
    body  nil
    image nil
  end
end
