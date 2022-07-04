# https://github.com/duleorlovic/rails_settings_in_cache_and_beta_features/blob/main/app/helpers/beta_helper.rb
module BetaHelper
  # example of usage:
  # <% if beta :name_of_feature %>
  #   <div>Something</div>
  # <% end %>
  # <%= beta :name_of_feature, render( "something") %>
  # redirect_to(root_path) if view_context.beta(:name_of_feature)
  #
  # to make feature available to all, add it to MySetting[:live_features]
  # some can see non live features if it is listed in MySettings[:beta_users]
  # for features on non logged in pages (for example GET homepage) you can
  # override default with url param: ?enable_feature=name_of_feature
  def beta(symbol_of_feature, content = nil) # rubocop:todo Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
    if MySetting[:live_features].to_s.split(/[\s,]+/).include? symbol_of_feature.to_s
      live_feature = true
    elsif defined?(current_user) &&
          current_user.is_a?(User) &&
          MySetting[:beta_users].to_s.include?(current_user.email)
      beta_user = true
    elsif defined?(params) &&
          # in mailer params are not available so check before use it
          params[:enable_feature] == symbol_of_feature.to_s
      live_feature_by_param = true
    end

    if live_feature || beta_user || live_feature_by_param
      if content.present?
        content
      else
        true
      end
    else
      false
    end
  end
end
