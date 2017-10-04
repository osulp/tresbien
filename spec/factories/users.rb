FactoryGirl.define do
  factory :user, aliases: ['claimant'] do
    full_name "Ross, Bob"
    email "bross@oregonstate.edu"
    username 'bross'
    pidm '111111'
    activity_code 'AB123'
    osu_id '9312345678'
    certifier false
    admin false
    association :organization, factory: :organization
    factory :user_admin, aliases: ['admin'] do
      full_name "Ross, Bob A"
      email "brossa@oregonstate.edu"
      admin true
      certifier false
    end
    factory :user_certifier, aliases: ['certifier'] do
      full_name "Ross, Bob C"
      email "brossc@oregonstate.edu"
      certifier true
      admin false
    end
    factory :user_certifier_admin, aliases: ['certifier_admin'] do
      full_name "Ross, Bob A.C."
      email "brossac@oregonstate.edu"
      certifier true
      admin true
    end
  end
end
