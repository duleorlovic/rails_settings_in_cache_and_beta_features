# https://github.com/duleorlovic/rails_settings_in_cache_and_beta_features/blob/main/app/models/my_setting.rb
class MySetting < ApplicationRecord
  validates :name, presence: true

  # Never update values directly, use MySetting[:foo]='one,two'
  # You can update using rails console or in your custom methods
  # Return value is always string.
  # For unknown key, nil is returned
  # Integers are OK in format "123" so .to_i can be safelly performed
  # (all money value should be in cents)

  class << self
    # This method returns the values of the config simulating a Hash, like:
    #   MySetting[:foo]
    # It can also bring Arrays of keys, like:
    #   MySetting[:foo, :bar]
    # ... so you can pass it to a method using *.
    # It is memoized, so it will be correctly cached.
    def [](*keys)
      if keys.size == 1
        get keys.shift
      else
        keys.map { |key| get key }
      end
    end

    def []=(key, value)
      set key, value
    end

    def get_without_cache(key)
      my_setting = find_by_name(key)
      return my_setting.value if my_setting

      # to return nil in case of unknown key
      nil
    end

    private

    def get(key)
      Rails.cache.fetch("/configurations/#{key}") do
        get_without_cache(key)
      end
    end

    def set(key, value)
      find_or_create_by!(name: key).update(value: value)
      Rails.cache.write("/configurations/#{key}", value)
      value
    end
  end
end
