FactoryGirl.define do
    sequence :email do |n|
        "person#{n}@example.com"
    end
    factory :user do |f|
        f.first_name "Testing"
        f.last_name "User"
        f.email { generate(:email) }
        f.password "21013907"
        f.password_confirmation "21013907"
    end

    factory :course do |c|
        c.course_name "SYSC 2006"
    end
end
