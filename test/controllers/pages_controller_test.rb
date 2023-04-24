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

  test "live_features" do
    get root_path
    assert_match /landing.feature/, response.body

    MySetting[:live_features] = ""
    get root_path
    refute_match /landing.feature/, response.body
  end

  test "beta_user_emails" do
    user = users(:non_beta_user)
    sign_in user
    get root_path
    refute_match /delete account/, response.body

    MySetting[:beta_user_emails] = user.email
    get root_path
    assert_match /delete account/, response.body
  end

  test "live_feature_by_param" do
    user = users(:non_beta_user)
    sign_in user
    get root_path
    refute_match /delete account/, response.body

    get root_path enable_feature: :delete_account_feature
    assert_match /delete account/, response.body
  end
end
