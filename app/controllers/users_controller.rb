class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_current_user, only: [:show]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @upcoming_events = @user.upcoming_events
    @prev_events = @user.previous_events
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      session[:current_user_id] = @user.id
      redirect_to @user, notice: 'User was successfully created.'
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    if current_user

      begin
        @user = User.find(params[:id])
      rescue StandardError => e
        flash[:alert] = e.to_s
        redirect_to root_path
      end
    else
      session[:previous_url] = request.fullpath unless request.fullpath =~ Regexp.new('/user/')
      redirect_to sign_in_path
    end
  end

  def set_current_user
    if current_user.nil?
      session[:previous_url] = request.fullpath unless request.fullpath =~ Regexp.new('/user/')
      redirect_to sign_in_path
    end
    @current_user = current_user
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name)
  end
end
