class MypagesController < ApplicationController

  def show
  end

  def status
    @items = current_user.items
  end

  def logout
  end

  def edit
  end
end
