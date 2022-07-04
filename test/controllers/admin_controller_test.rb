require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get settings_and_beta_features" do
    sign_in users(:user)
    get admin_settings_and_beta_features_url
    assert_response :success
  end
end
