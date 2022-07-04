# rubocop:disable Layout/HeredocIndentation
run <<BASH
rails g model MySetting name value:text description:text
rails g controller admin settings_and_beta_features
BASH

get "https://raw.githubusercontent.com/duleorlovic/rails_settings_in_cache_and_beta_features/main/app/controllers/admin_controller.rb",
    "app/controllers/admin_controller.rb"

get "https://raw.githubusercontent.com/duleorlovic/rails_settings_in_cache_and_beta_features/main/app/models/my_setting.rb",
    "app/models/my_setting.rb"
get "https://raw.githubusercontent.com/duleorlovic/rails_settings_in_cache_and_beta_features/main/app/helpers/beta_helper.rb",
    "app/models/my_setting.rb"

get "https://raw.githubusercontent.com/duleorlovic/rails_settings_in_cache_and_beta_features/main/app/views/admin/settings_and_beta_features.html.erb",
    "app/views/admin/settings_and_beta_features.html.erb"

empty_directory "app/forms"
get "https://raw.githubusercontent.com/duleorlovic/rails_settings_in_cache_and_beta_features/main/app/forms/settings_and_beta_features_form.rb",
    "app/forms/settings_and_beta_features_form.rb"

# rubocop:enable Layout/HeredocIndentation
