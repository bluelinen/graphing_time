class UsersController < ApplicationController
  before_action :set_user, except: [:create, :index]

  # GET /users
  def index
    @users = User.all

    render json: @users.to_json_display
  end

  # GET /users/1
  def show
    render json: @user.to_json_display(:show)
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def add_friend
    @user.add_friend(params[:friend_id])
    render json: {status: :ok}
  end

  def search
    results = @user.search(params[:query])
    results.map! do |r|
      json = r[:user].to_json_display(:show)
      json[:path] = r[:path]
      json
    end
    render json: results
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :website)
    end
end
