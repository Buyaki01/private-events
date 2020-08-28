class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(name: params[:name])
    session[:current_user_id] = @user.id if @user

    respond_to do |format|
      if @user

        path_url = session[:previous_url] || user_path(@user)

        format.html { redirect_to path_url, notice: 'You have successfully logged in' }
        format.json { render @user, status: :'logged in' }
      else
        format.html { render :new }
        format.json { render json: { error: 'failed login' }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    session[:current_user_id] = nil
    respond_to do |format|
      format.html { redirect_to sign_in_url, notice: 'You have successfully logged out.' }

      format.json { head :no_content }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def session_params
    params.fetch(:session, {})
  end
end
