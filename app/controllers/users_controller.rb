class UsersController < ApplicationController
  before_action :find_user, :except => :index
  def index
    @users = User.order(:name)
  end

  def show
  end

  def repos
    @github_repos = @user.github_repos || []
    render :json => @github_repos
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
