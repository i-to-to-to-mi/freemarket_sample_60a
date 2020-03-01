class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  require "payjp"

  def new
    @user = User.new
  end

  def create
    if params[:sns_auth] == 'true'
      pass = Devise.friendly_token[0,20]
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
    end
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @address = @user.build_address
    render :sms_confirmation
  end

  def sms_confirmation
  end

  def sms_recieved
  end


  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)

    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_address(@address.attributes)
    @user.save
    sign_in(:user, @user)
    render :register_credit_card
  end

  

  
  def register_credit_card
    Payjp.api_key = 'sk_test_a0029dc5466705b77c5d7bab'
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(card: params['payjp-token'])
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
        if @card.save
          redirect_to action: "complete"
        else
          redirect_to action: "register_credit_card"
          notice[:delete] = "なんかちげー"
        end
    end
  end

  def complete
  end

  def edit_address
  end


  def tmp_address
  end

  def new_address
    @address = Address.new
  end

  protected

  def address_params
    params.require(:address).permit(:postal_code, :prefectures, :city, :address, :building, :phone_number)
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

end

