FactoryBot.define do
  factory :access_token do
    token_digest { nil }
    user
    api_key
    accessed_at { Time.now }
  end
end
