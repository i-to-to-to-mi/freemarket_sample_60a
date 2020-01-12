class AddressesController < ApplicationController

  def new
    @address = Address.new
  end 

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to root_path, notice: '住所を登録しました'
    else
      render :new
    end
  end

 
  private
  def address_params
    params.require(:address).permit(:postal_code, :Prefectures, :city, :address1, :address2, :address_phone_number).merge(user_id: current_user.id)
  end


end
