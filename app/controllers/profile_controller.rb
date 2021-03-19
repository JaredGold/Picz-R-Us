class ProfileController < ApplicationController
  before_action :find_user, :find_user_profile, only: %i[show create new edit update]
  before_action :find_user_profile, only: %i[show create new edit update]
  before_action :authenticate_user!, only: %i[show create new edit]
  before_action :find_user_name, only: %i[show new]

  def show
    
  end
  
  def new
    # Check if the user has a profile and if they do send them to the profile page or else
    # Create a new profile for the user to fill out 
    if current_user.profile != nil
      redirect_to profile_path
    end
    @profile = Profile.new
  end

  def create
    # Pass in the paramaters the user has created in the new function set up in the view
    @profile = current_user.create_profile(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: "Profile was successfully created." }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
    
  end

  def edit
    # Edit the current user's profile
    @profile = current_user.profile
  end

  def update
    respond_to do |format|
      if current_user.profile.update(profile_params)
        format.html { redirect_to profile_path, notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: profile+path}
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
  def profile_params
    # Check the required paramaters for the update and create functions
    params.require(:profile).permit(:about_me, :age)
  end

  def find_user
    # Set the current user
    @user = current_user
  end

  def find_user_profile
    # Set the current user's profile
    @user_profile = current_user.profile
  end

  def find_user_name
    # Front end styling for the user's first and last name
    @name = "#{@user.first_name} #{@user.last_name}"
  end
end
