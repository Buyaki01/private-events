require 'rails_helper'

RSpec.describe 'Authentication Requests', type: :request do
  let(:name) { { name: 'name' } }

  describe 'when user is not logged in' do
    it 'renders the signin page' do
      get '/sign_in'
      expect(response).to render_template(:new)
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
      expect(response).to have_http_status(200)
    end

    it 'renders the sign_up page' do
      get '/sign_up'
      expect(response).to render_template(:new)
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
      expect(response).to have_http_status(200)
    end

    it 'signs up a new user' do
      post '/users', params: { user: name }
      user = User.find_by(name: 'name')
      expect(response).to redirect_to(user_path(user.id))
      expect(response).to have_http_status(:found)
      expect(response).to have_http_status(302)
    end

    it 'should not access the show user page if not signed in' do
      get '/users/1'
      expect(response).to redirect_to(sign_in_path)
      expect(response).to have_http_status(:found)
      expect(response).to have_http_status(302)
    end
  end

  describe 'when user is logged in' do
    before(:each) do
      post '/users', params: { user: name }
      post '/sign_in', params: name
    end

    it 'registered user signs in successfully' do
      post '/users', params: { user: name }
      post '/sign_in', params: name
      user = User.find_by(name)

      expect(response).to redirect_to(user_path(user.id))
      expect(response).to have_http_status(:found)
      expect(response).to have_http_status(302)
    end

    it 'logs out a user successfully' do
      post '/users', params: { user: name }
      post '/sign_in', params: name
      delete '/sign_out'
      expect(flash[:notice]).to eq 'You have successfully logged out.'
      expect(response).to redirect_to(sign_in_path)
      expect(response).to have_http_status(:found)
      expect(response).to have_http_status(302)
    end
  end
end
