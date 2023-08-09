require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    let!(:user1) { create(:user, email: 'newuser@gmail.com') }
    let!(:user2) { create(:user, email: 'newuser2@gmail.com') }
  
    describe 'GET #index' do
        # This returns an empty body for some reason,
        # even running rails server in test ENV works
        # with postman just fine. So I'm not sure why 
        # the response is empty here.
        it 'returns all users as JSON' do
            get :index, format: :json

            json_response = JSON.parse(response.body)

            expect(response).to have_http_status(:ok)
            expect(json_response.length).to eq(2) # Assuming there are 2 users

            expect(json_response[0]['name']).to eq(user1.name)
            expect(json_response[0]['email']).to eq(user1.email)

            expect(json_response[1]['name']).to eq(user2.name)
            expect(json_response[1]['email']).to eq(user2.email)
        end
    end

    describe 'POST #create' do
        context 'with valid params' do
            let(:valid_attributes) {
                { name: 'John Doe', email: 'john.doe@example.com' }
            }

            it 'creates a new user' do
                expect {
                    post :create, params: { user: valid_attributes }, format: :json
                }.to change(User, :count).by(1)
            end

            #  Same issue with the response body here
            it 'returns the newly created user as JSON' do
                post :create, params: { user: valid_attributes }, format: :json

                json_response = JSON.parse(response.body)

                expect(response).to have_http_status(:created)
                expect(json_response['name']).to eq('John Doe')
                expect(json_response['email']).to eq('john.doe@example.com')
            end
        end
    
        context 'with invalid params' do
            let(:invalid_attributes) {
                { name: nil, email: 'invalid-email' }
            }

            it 'does not create a new user' do
                expect {
                    post :create, params: { user: invalid_attributes }, format: :json
                }.not_to change(User, :count)
            end

            it 'returns an unprocessable entity response' do
                post :create, params: { user: invalid_attributes }, format: :json

                expect(response).to have_http_status(:unprocessable_entity)
            end
        end
      end

  end
  