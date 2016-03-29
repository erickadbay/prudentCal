require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  include Devise::TestHelpers

  test "index should render correct template and layout" do
      get :index
      assert_template :index
      assert_template layout: "layouts/application"
  end

  test "new should render correct layout" do
      get :new
      assert_template :new, partial: "_form"
      assert_template layout: "layouts/application"
  end
end
