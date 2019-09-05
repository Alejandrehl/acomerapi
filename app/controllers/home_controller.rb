class HomeController < ActionController::Base

 PLANS = [
    {
      id: "gratis",
      name: "Gratis",
      price: "0",
      trial_period_days: 7,
      status: "active"
    },
    {
      id: "foodtruck",
      name: "Foodtruck",
      price: "0.5",
      currency: "UF",
      interval: "month",
      interval_count: 1,
      trial_period_days: 0,
      status: "active"
    },
    {
      id: "restaurant",
      name: "Restaurant",
      price: "2.2",
      currency: "UF",
      interval: "month",
      interval_count: 1,
      trial_period_days: 0,
      status: "active"
    }
  ]
  
  def index
    # return redirect_to new_user_session_path unless current_user.present?
    @plans = PLANS
  end

  def privacy_policy
  end

end