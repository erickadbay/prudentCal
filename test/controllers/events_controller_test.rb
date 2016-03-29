require 'test_helper'

class EventsControllerTest < ActionController::TestCase
    # test "the truth" do
    #   assert true
    # end
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

    test "edit should render correct layout" do
        get :edit
        assert_template :edit, partial: "_formedit"
        assert_template layout: "layouts/application"
    end

    test "show should render correct layout" do
        get :show
        assert_template :show
        assert_template layout: "layouts/application"
    end
end
