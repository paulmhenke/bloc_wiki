class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Blocipedia - #{current_user.email}",
      amount: User::AMOUNT
    }
  end
  
  def create #Creates a Stripe Customer object for associating with the charge
    User.transaction do
      begin
      customer = Stripe::Customer.create(
        email: current_user.email,
        card: params[:stripeToken]
      )
      
      charge = Stripe::Charge.create(
        customer: customer.id, 
        amount: User::AMOUNT,
        description: "Premium Blocipedia - #{current_user.email}",
        currency: 'usd'
      )
      
      flash[:success] = "Successful charge! Enjoy Blocipedia Premium!"
      current_user.update_attributes!(role: "premium")
      redirect_to wikis_path
      
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
  end
end
end
