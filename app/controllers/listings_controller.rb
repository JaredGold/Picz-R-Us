class ListingsController < ApplicationController
  before_action :set_listing, only: %i[show edit update destroy find_seller]
  before_action :find_seller, :find_type, only: %i[show]

  # GET /listings or /listings.json
  def index
    @listings = Listing.all
    @user = User.all
    @type = Type.all
  end

  # GET /listings/1 or /listings/1.json
  def show
    
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings or /listings.json
  def create
    @listing = Listing.new(listing_params)

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
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: "Listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def listing_params
      params.require(:listing).permit(:user_id, :type_id, :name, :duration, :price, :description)
    end

    # Find listing owner
    def find_seller()
      @seller = User.find(@listing.user_id)
    end

    def find_type()
      @type = Type.find(@listing.type_id)
    end

    
end
