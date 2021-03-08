class ProfileController < ApplicationController
  before_action :find_user, :find_user_profile, only: %i[show create new edit update]
  before_action :authenticate_user!, only: %i[show create new edit]
  before_action :find_user_name, only: %i[show new]

  def show
    
  end
  
  def new
    @profile = Profile.new
  end

  def create
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
  end

  def update
    @profile = Profile.find(current_user.id)
    @profile.update(profile_params)

    redirect_to profile_path
  end

  private
  
  def profile_params
    params.permit(:user_id, :about_me, :age)
  end

  def find_user
    @user = current_user
  end

  def find_user_profile
    @user_profile = current_user.profile
  end

  def find_user_name
    @name = "#{@user.first_name} #{@user.last_name}"
  end
end
