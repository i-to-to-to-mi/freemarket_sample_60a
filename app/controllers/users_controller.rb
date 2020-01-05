class UsersController < ApplicationController
  def show
  end

  def edit
  end 

  def update
    if current_user.update(user_params)
      redirect_to edit_user_path(@user),notice: '変更しました'
    else
      render :edit
    end
  end


  private
  def user_params
    params.require(:user).permit(:nickname, :introduction)
  end
end
  

