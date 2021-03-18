class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[webhook]
  before_action :set_images, only: %i[footage]
  before_action :set_card, only: %i[footage]


  def footage
  end

  def unsuccessful
  end
  
  def webhook
    payment_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_id)

    listing = Listing.find(payment.metadata.listing_id)

    buyer = User.find(payment.metadata.user_id)

    PurchasedFootage.create(user_id: buyer.id, listing_id: listing.id)
  end

  private

  def set_images
    if current_user.purchased_footages != nil
      @image = current_user.purchased_footages.all
      @images = []
      @image.each do |image|
        @images << Listing.find(image.listing_id)
      end
      @images.reverse
    else
      redirect_to root_path
    end
  end

  def set_card
    @card = "border border-black 
      flex flex-col justify-between items-center p-3 rounded-3xl 
      bg-white border-opacity-25 shadow-lg"
  end

end
