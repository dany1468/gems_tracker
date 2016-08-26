FactoryGirl.define do
  factory :ignoring_gem do
    sequence(:name) {|n| "ignoring_gem_#{n}" }
    registered_version '0.1.0'
  end
end
