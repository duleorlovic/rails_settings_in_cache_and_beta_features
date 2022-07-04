require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_path
    assert_response :success
  end

  test "sign_in_development" do
    get sign_in_development_path users(:user).id
    assert_equal "only_development", response.body
  end

  test "landing_feature" do
    get root_path
    refute_match /landing.feature/, response.body

    MySetting[:live_features] = "landing_feature"
    get root_path
    assert_match /landing.feature/, response.body
  end
end
