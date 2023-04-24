require 'test_helper'

class BetaHelperTest < ActionView::TestCase
  test "live_feature" do
    refute beta(:test_feature)

    MySetting[:live_features] = "test_feature"
    assert beta(:test_feature)
  end

  test "beta_user_emails" do
    # also tested in root controller
    user = users(:non_beta_user)

    refute beta(:test_feature, user)

    MySetting[:beta_user_emails] = user.email
    assert beta(:test_feature, user)
  end

  test "background current_user is not available so we need to pass it as argument" do
    # ActionView::Template::Error: Devise could not find the `Warden::Proxy` instance on your request environment.
    Article.last.update! title: "new_title"
  end

  test "use in service" do
    user = users(:user)
    result = MyService.new(user).perform
    assert result

    user = users(:non_beta_user)
    result = MyService.new(user).perform
    refute result
  end
end
