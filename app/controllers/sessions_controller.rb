class SessionsController < ApplicationController
  # before_action :set_session, only: [:show, :edit, :update, :destroy]

  def new

  end

  def create
    @user = User.find_by(name: params[:name])
    session[:current_user_id] = @user.id

    respond_to do |format|
      if @user

        format.html { redirect_to user_path(@user), notice: 'You have successfully logged in'}
        format.json { render @user, status: :'logged in' }
      else
        format.html { render :new }
        format.json { render json: {error: "failed login"}, status: :unprocessable_entity }
      end
    end
  end

 

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    @session.destroy
    respond_to do |format|
      format.html { redirect_to sessions_url, notice: 'Session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    # Only allow a list of trusted parameters through.
    def session_params
      params.fetch(:session, {})
    end
end
