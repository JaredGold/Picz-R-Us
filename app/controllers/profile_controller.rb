class ProfileController < ApplicationController
before_action :authenticate_user!, only: %i[show]

  def show
    @user = current_user
    @name = "#{@user.first_name} #{@user.last_name}"
    @profile = current_user.profile
  end
end
