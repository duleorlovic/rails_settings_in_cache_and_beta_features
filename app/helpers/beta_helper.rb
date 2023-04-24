# https://github.com/duleorlovic/rails_settings_in_cache_and_beta_features/blob/main/app/helpers/beta_helper.rb
module BetaHelper
  # Three usage:
  #
  # * in controller:
  # redirect_to(root_path) if helpers.beta? :delete_account_feature
  #
  # * in view:
  # <% if beta? :delete_account_feature %>
  #   <div>Something</div>
  # <% end %>
  # in partial that is rendered in background broadcasts you need to pass
  # all variables to the partial and you need to use second argument in beta
  # <% if beta? :delete_account_feature, current_user %>
  #
  #
  # * in forms:
  #   ApplicationController.helpers.beta? :subscription_required_for_new_users_feature, user
  #
  # To test new feature you can enable in three ways:
  #
  # * to make feature available to all you can enable feature on admin page (this will add feature to MySetting[:live_features]),
  # * to enable for specific users you can add email to MySetting[:beta_user_emails]
  # * use param: ?enable_feature=delete_account_feature to enable on non logged in pages (for example GET homepage)
  #
  # To enable in test: MySetting[:live_features] = "delete_account_feature"
  def beta?(symbol_of_feature, user = defined?(current_user) && current_user) # rubocop:todo Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    if MySetting[:live_features].to_s.split(/[\s,]+/).include? symbol_of_feature.to_s
      live_feature = true
    elsif user.is_a?(User) &&
          MySetting[:beta_user_emails].to_s.include?(user.email)
      beta_user = true
    elsif defined?(params) &&
          params.present? &&
          # in mailer params are not available so check before use it
          params[:enable_feature] == symbol_of_feature.to_s
      live_feature_by_param = true
    end

    live_feature || beta_user || live_feature_by_param
  end
end
