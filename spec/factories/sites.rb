# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site do
    url "MyString"
    scapped false
    valid false
    title "MyString"
    batch nil
  end
end
