class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[webhook]

  def success
  end

  def unsuccessful
  end
  
  def webhook
    payment_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_id)

    listing = Listing.find(payment.metadata.listing_id)

    buyer = User.find(payment.metadata.user_id)

    puts "Listing is #{listing}"
    puts "Buyer is #{buyer}"
  end

end
