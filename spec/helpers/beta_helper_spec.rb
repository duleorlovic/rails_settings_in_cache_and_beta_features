# https://github.com/duleorlovic/rails_settings_in_cache_and_beta_features/blob/main/spec/helpers/beta_helper_spec.rb
RSpec.describe BetaHelper do
  fixtures :all

  # TODO: Not sure if those tests are thread safe since they use MySettings
  it "live_feature to enable feature" do
    expect(beta?(:test_feature)).to be_falsey

    MySetting[:live_features] = "test_feature"

    expect(beta?(:test_feature)).to be_truthy
  end

  it "beta_user_emails to enable feature" do
    # also tested in root controller
    user = users(:user)
    MySetting[:beta_user_emails] = ""
    MySetting[:live_features] = ""

    expect(beta?(:test_feature, user)).to be_falsey

    MySetting[:beta_user_emails] = user.email

    expect(beta?(:test_feature, user)).to be_truthy
  end

  # Not tested live_feature_by_param since we need to make a real request
  # Usage is tested in requests specs
end
