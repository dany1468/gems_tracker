FactoryGirl.define do
  factory :unread_gem do
    sequence(:name) {|n| "unread_gem_#{n}" }
    version '0.1.0'
    url 'https://github.io/unread_gems'
  end
end
