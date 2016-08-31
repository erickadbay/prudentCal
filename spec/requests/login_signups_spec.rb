require 'spec_helper'

RSpec.describe "LoginSignups", type: :request do
    # it "User signs up when clicking the sign up button" do
    #     user = FactoryGirl.build(:user)
    #     visit root_path
    #     click_link "Sign Up"
    #     fill_in "Email", :with => user.email
    #     fill_in("Password", with: user.password, :match => :prefer_exact)
    #     fill_in("Password confirmation", with: user.password, :match => :prefer_exact)
    #     fill_in "First name", :with => user.first_name
    #     fill_in "Last name", :with => user.last_name
    #     page.select 'Professor', :from => 'Role'
    #     click_button "Sign up"
    #     current_path.should eq(root_path)
    # end

    it "User logs in when clicking the login button and clicks on new course" do
        professor = FactoryGirl.build(:user)
        visit root_path
        click_link "Log In"
        fill_in "Email", :with => professor.email
        fill_in("Password", with: professor.password, :match => :prefer_exact)
        click_button "Log in"
        click_link "New Course"
        current_path.should eq(new_course_path)
    end
end
