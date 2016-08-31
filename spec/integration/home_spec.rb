require 'spec_helper'

describe 'home page' do
  it 'welcomes the user' do
    visit '/'
    within("#banner") do
        page.should have_content('Sign Up')
    end
  end
end
