class MyService
  def initialize(user)
    @user = user
  end

  def perform
    in_beta = Class.new.extend(BetaHelper).beta?(:delete_account_feature, @user)
    if in_beta
      true
    else
      false
    end
  end
end
