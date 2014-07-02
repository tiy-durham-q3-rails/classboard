class HelpRequestsController < ApplicationController
  before_action :require_login
  before_action :set_help_request, only: [:show, :edit, :update, :resolve]
  before_action :require_edit, only: [:edit, :update]
  before_action :require_resolve, only: [:resolve]


  # GET /help_requests
  # GET /help_requests.json
  def index
    @help_requests = HelpRequest.unresolved.includes(:user)
  end

  # GET /help_requests/1
  # GET /help_requests/1.json
  def show
  end

  # GET /help_requests/new
  def new
    @help_request = current_user.help_requests.build
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /help_requests/1/edit
  def edit
  end

  # POST /help_requests
  # POST /help_requests.json
  def create
    @help_request = current_user.help_requests.build(help_request_params)

    respond_to do |format|
      if @help_request.save
        format.html { redirect_to help_requests_path, notice: 'Help request was successfully created.' }
        format.js do
          @help_requests = HelpRequest.unresolved.includes(:user)
          render :create
        end
      else
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /help_requests/1
  # PATCH/PUT /help_requests/1.json
  def update
    if @help_request.update(help_request_params)
      redirect_to help_requests_path, notice: 'Help request was successfully updated.'
    else
      render :edit
    end
  end

  def resolve
    respond_to do |format|
      @help_request.resolve!
      format.html { redirect_to help_requests_path }
      format.js do
        @help_requests = HelpRequest.unresolved.includes(:user)
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_help_request
    @help_request = HelpRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def help_request_params
    params.require(:help_request).permit(:repo, :nature, :attempted, :resolved_at)
  end

  def require_edit
    unless @help_request.can_edit?(current_user)
      redirect_to :login, alert: "You do not have permissions to do that."
    end
  end

  def require_resolve
    unless @help_request.can_resolve?(current_user)
      redirect_to :login, alert: "You do not have permissions to do that."
    end
  end
end
