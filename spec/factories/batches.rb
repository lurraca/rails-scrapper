# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :batch do
    status "MyString"
    keywords "MyText"
    started_time "2012-09-27 02:35:19"
    finish_time "2012-09-27 02:35:19"
  end
end
