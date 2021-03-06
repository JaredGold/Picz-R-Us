class ProfileController < ApplicationController
before_action :authenticate_user!, only: %i[show]
before_action :find_user, :find_user_profile, only: %i[show create new]

  def show
    @name = "#{@user.first_name} #{@user.last_name}"
  end
  
  def new
    @profile = Profile.new
  end

  def create
    @profile = @user_profile.create(listing_params)


    # TODO Fix below code to work with about me page
    # respond_to do |format|
    #   if @about_me.save
    #     format.html { redirect_to @listing, notice: "Listing was successfully created." }
    #     format.json { render :show, status: :created, location: @listing }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @listing.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  private
  
  def find_user
    @user = current_user
  end

  def find_user_profile
    @user_profile = current_user.profile
  end

end
