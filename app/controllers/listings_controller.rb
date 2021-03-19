class ListingsController < ApplicationController
  before_action :set_listing, only: %i[show edit update destroy find_seller]
  before_action :find_seller, only: %i[show]
  before_action :authenticate_user!, only: %i[new]
  before_action :set_card, only: %i[index]
  

  # GET /listings or /listings.json
  def index
    @listings = Listing.all
    @user = User.all
  end

  # GET /listings/1 or /listings/1.json
  def show
    # Check to see if the user is signed in before creating a button using stripe
    if user_signed_in?
      session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        customer_email: current_user.email,
        line_items: [{
          name: @listing.name,
          description: @listing.description,
          # images: @listing.footage,
          # price_data: {
            # },
          amount: (@listing.price * 100).to_i,
          currency: 'aud',
          quantity: 1,
          }],
        payment_intent_data:{
          metadata:{
            listing_id: @listing.id,
            user_id: current_user.id
          }
        },
        mode: 'payment',
        success_url: "#{root_url}footage",
        cancel_url: root_url,
      })
    
      @session_id = session.id
    end
  end

  # GET /listings/new
  def new
    # Create a new listing but don't save until a later function is run
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
    # Check if user is signed in and if they are and they aren't the owner of the
    # listing redirect the user to the root path
    if user_signed_in?
      if current_user.id != @listing.user.id
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  # POST /listings or /listings.json
  def create
    # create a listing using the current user's id and the listing paramaters
    @listing = current_user.listings.create(listing_params)

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: "Listing was successfully created." }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1 or /listings/1.json
  def update
    # Save the edited listing if all of the params are included. 
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: "Listing was successfully updated." }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1 or /listings/1.json
  def destroy
    # Destroy the current listing
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: "Listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      # Set the current listing to the id paramater passed through the website
      @listing = Listing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def listing_params
      # Check that the following types are included in the paramaters
      params.require(:listing).permit(:user_id, :name, :price, :description, :footage)
    end

    # Find listing owner
    def find_seller
      # Check who is the owner of the current listing
      @seller = User.find(@listing.user_id)
    end

    def set_card
      # Front end visual classes passed into the views
      @card = "w-80 h-full min-h-full border border-black 
      flex flex-col justify-between items-center px-3 py-3 rounded-3xl 
      bg-white border-opacity-25 shadow-lg"
    end
end
