require 'rails_helper'

RSpec.describe 'Event Requests', type: :request do
  describe 'when user is not logged in' do
    it 'should not access events page' do
      get '/events'
      check_expectations
    end

    it 'should not be able to access events to attend' do
      get '/attend_events/'
      check_expectations
    end

    it 'should not be able to attend events' do
      post '/attend_events/', params: { event_ids: [1, 2] }
      check_expectations
    end

    it 'should not be able to create an event' do
      get '/events/new'
      check_expectations
    end
  end
  describe 'when the user is logged in' do
    let(:name) { { name: 'name' } }
    before :each do
      post '/users', params: { user: name }
      post '/sign_in', params: name
    end
    it 'should access the events page' do
      get '/events'
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
      expect(response).to have_http_status(200)
    end
    it 'should be able to access events to attend' do
      get '/attend_events/'
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
      expect(response).to have_http_status(200)
    end

    it 'should be able to create an event' do
      get '/events/new'
      event = { description: 'description', date: '12/08/2020' }

      user = User.find_by(name)

      post '/events', params: { event: event }
      event = Event.where(creator_id: user.id)[0]

      expect(response).to redirect_to(event_path(event.id))
      expect(response).to have_http_status(:found)
      expect(response).to have_http_status(302)
      expect(user.events_created).to eq [event]
      expect(flash[:notice]).to eq('Event was successfully created.')
    end

    it 'should be able to attend events' do
      event_one = { description: 'description one', date: '12/08/2020' }
      event_two = { description: 'description two', date: '29/08/2020' }
      event_three = { description: 'description three', date: '29/28/2020' }
      user = User.find_by(name)

      post '/events', params: { event: event_one }
      post '/events', params: { event: event_two }
      post '/events', params: { event: event_three }
      events = Event.where(creator_id: user.id)
      attended_events = []
      attended_events << events.first << events.last
      events_id = attended_events.map(&:id)
      post '/attend_events', params: { event_ids: events_id }

      expect(response).to redirect_to(user_path(user.id))
      expect(response).to have_http_status(:found)
      expect(response).to have_http_status(302)
      expect(user.attended_events).to eq attended_events
      expect(flash[:notice]).to eq('You have successfully registered for the chosen event(s)')
    end

    it '/events/{id} path is working correctly' do
      # post '/users', params: params
      # post '/sign_in', params: name

      post '/events', params: { event: { description: 'description one', date: '12/08/2020' } }

      user = User.find_by(name)
      user_id = user.id
      event_id = Event.where(creator_id: user_id)[0].id

      get "/events/#{event_id}"
      expect(response).to render_template(:show)
      expect(response).to be_successful
      expect(response.code).to eq '200'
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('description one')
      expect(response.body).to include(Date.parse('12/08/2020').to_s)
    end
  end
end

private
def check_expectations
  expect(response).to redirect_to(sign_in_path)
  expect(response).to have_http_status(:found)
  expect(response).to have_http_status(302)
end
