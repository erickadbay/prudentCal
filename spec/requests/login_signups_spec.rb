require 'spec_helper'

RSpec.describe "LoginSignups", type: :request do
    it "logs user in when clicking the login button" do
        user = Factory(:user)
        visit root_path
    end
end
