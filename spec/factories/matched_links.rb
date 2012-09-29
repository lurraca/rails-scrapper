# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :matched_link do
    site nil
    keyword "MyString"
    link_text "MyText"
    link_url "MyText"
  end
end
