class AllowedAccountsController < ApplicationController
  def new
    @allowed_account = AllowedAccount.new
  end

  def create
    @allowed_account = AllowedAccount.new(allowed_account_params)

    if @allowed_account.save
      redirect_to users_path, notice: "#{@allowed_account.github} is now an authorized account."
    else
      render :new
    end
  end

  def destroy
    @allowed_account = AllowedAccount.find(params[:id])
    @allowed_account.destroy
    redirect_to users_path, notice: "#{@allowed_account.github} is no longer an authorized account."
  end

  private

  def allowed_account_params
    params.require(:allowed_account).permit(:github)
  end
end
