class HelpRequestsController < ApplicationController
  before_action :require_login
  before_action :set_help_request, only: [:show, :edit, :update, :destroy, :resolve]

  # GET /help_requests
  # GET /help_requests.json
  def index
    @help_requests = HelpRequest.unresolved
  end

  # GET /help_requests/1
  # GET /help_requests/1.json
  def show
  end

  # GET /help_requests/new
  def new
    @help_request = current_user.help_requests.build
  end

  # GET /help_requests/1/edit
  def edit
  end

  # POST /help_requests
  # POST /help_requests.json
  def create
    @help_request = current_user.help_requests.build(help_request_params)

    if @help_request.save
      redirect_to help_requests_path, notice: 'Help request was successfully created.'
    else
      render :new
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

  # DELETE /help_requests/1
  # DELETE /help_requests/1.json
  def destroy
    @help_request.destroy
    redirect_to help_requests_url, notice: 'Help request was successfully destroyed.'
  end

  def resolve
    @help_request.resolve!
    redirect_to help_requests_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_help_request
      @help_request = HelpRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def help_request_params
      params.require(:help_request).permit(:nature, :attempted, :resolved_at)
    end
end
