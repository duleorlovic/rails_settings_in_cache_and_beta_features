class AdminController < ApplicationUserController
  before_action :_check_admin?

  def settings_and_beta_features
    @settings_and_beta_features_form = SettingsAndBetaFeaturesForm.new
  end

  def update_settings_and_beta_features
    @settings_and_beta_features_form = SettingsAndBetaFeaturesForm.new _settings_and_beta_features_form_params
    if @settings_and_beta_features_form.save
      redirect_to admin_settings_and_beta_features_path, notice: "Successfully updated"
    else
      flash.now[:alert] = @settings_and_beta_features_form.errors.full_messages.to_sentence
      render :settings_and_beta_features
    end
  end

  def _settings_and_beta_features_form_params
    params.require(:settings_and_beta_features_form).permit(
      live_features: [], settings: {},
    )
  end

  def _check_admin?
    redirect_to root_path, alert: "Only admin" unless current_user.admin?
  end
end
