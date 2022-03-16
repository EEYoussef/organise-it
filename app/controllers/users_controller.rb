class UsersController < ApplicationController
  # this is devise way to ensure that the user is loged in passing it on the show action
  #  so anyone can see the index of all users but only loged in to see users profiles
  before_action :authenticate_user!, only: [:show]
  
  
  
  #to grab all the users from the database and put them in an instance variable users
  def index 
    # @users = User.all
  end

# to grab a certain user by id and put it in the instance variable user
  def show
      @user= User.find(params[:id])
  end

  # to ensure that not any user can update or edit any other user except themselves
  # first we set the devise current user to instant variable user
  # 
  def edit
    @user = current_user
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html {redirect_to current_user , notice:"Successfully Updated"}
    end
  end
end


def user_params
  params.require(:user).permit(:bio,:first_name, :last_name)
end
end
