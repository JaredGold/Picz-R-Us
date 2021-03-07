class ProfileController < ApplicationController
before_action :authenticate_user!, only: %i[show]
before_action :find_user, :find_user_profile, only: %i[show create new]
before_action :find_user_name, only: %i[show new]

  def show
    
  end
  
  def new
    
  end

  def create
    @profile = Profile.create(profile_params)
    
  end

  private
  
  def profile_params
    params.permit(:about_me, :age, user_id: current_user.id)
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
