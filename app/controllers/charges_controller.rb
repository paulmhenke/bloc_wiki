class ChargesController < ApplicationController
require 'stripe'

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Blocipedia - #{current_user.email}",
      amount: User::AMOUNT
    }
  end
  
  def create 
    if current_user.customer_id.nil?
      customer = Stripe::Customer.create(
          email: current_user.email,
          card: params[:stripeToken]
        )
        current_user.customer_id = customer.id
    end
      
    User.transaction do
      begin
      customer = Stripe::Customer.retrieve(current_user.customer_id)
      customer.subscriptions.create(plan: "premium")
    
      flash[:success] = "Successful charge! Enjoy Blocipedia Premium!"
      current_user.update_attributes!(role: "premium")
      redirect_to wikis_path
      
      rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
      end
    end
  end
  
  def destroy
    customer = Stripe::Customer.retrieve(current_user.customer_id)
    subscription = customer.subscriptions.data.first.id
    customer.subscriptions.retrieve(subscription).delete
    
    current_user.update_attributes!(role: "standard")
    current_user.private_to_public
    
    redirect_to wikis_path
  end
    
end
