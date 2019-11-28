FactoryBot.define do
  factory :task do
    
    name { 'test_name' }
    detail { 'test_detail' }  
    user
  end
end
