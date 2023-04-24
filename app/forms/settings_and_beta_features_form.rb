class SettingsAndBetaFeaturesForm
  include ActiveModel::Model

  attr_accessor :live_features, :settings

  def save
    MySetting[:live_features] = live_features.reject { |f| f == "0" }.join(",")
    settings.each do |key, value|
      MySetting[key] = value.split(",").map(&:strip).join(",")
    end
  end
end
