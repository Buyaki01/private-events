require "rails_helper"

RSpec.describe "Event Requests", :type => :request do

    describe 'when user is not logged in' do
        it 'should not access events page' do
          get '/events'
          expect(response).to redirect_to(sign_in_path)
          expect(response).to have_http_status(:found)
          expect(response).to have_http_status(302)
        end

        it 'should not access the show user page' do
            get '/users/1'
            expect(response).to redirect_to(sign_in_path)
            expect(response).to have_http_status(:found)
            expect(response).to have_http_status(302)
        end

        # it 'should not attend events page' do
        #     get '/users/1'
        #     expect(response).to redirect_to(sign_in_path)
        #     expect(response).to have_http_status(:found)
        #     expect(response).to have_http_status(302)
        # end

        # it 'should not create events page' do
        #     get '/users/1'
        #     expect(response).to redirect_to(sign_in_path)
        #     expect(response).to have_http_status(:found)
        #     expect(response).to have_http_status(302)
        # end

    #     #it 'renders the sign_up page' do
    #       #get '/sign_up'
    #       expect(response).to render_template(:new)
    #       expect(response).to be_successful
    #       expect(response).to have_http_status(:ok)
    #       expect(response).to have_http_status(200)
    #     end
    
    #     it 'signs up a new user' do
    #       post '/users', params: { user: name }
    #       user = User.find_by(name: 'name')
    #       expect(response).to redirect_to(user_path(user.id))
    #       expect(response).to have_http_status(:found)
    #       expect(response).to have_http_status(302)
    #     end
    end
end