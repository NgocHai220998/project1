class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user&.authenticate(params[:session][:password])
      log_in user
      remember_check(user)
      redirect_to user
    else
      flash[:danger] = 'メールアドレスとパスワードの組み合わせが無効です'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def remember_check(user)
    if params[:session][:remember_me] == '1'
      remember user
    else
      forget user
    end
  end
end
