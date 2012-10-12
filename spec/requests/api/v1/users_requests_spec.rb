require 'spec_helper'


describe 'GET api/v1/users.json' do
  context 'client is not authenticated' do
    it 'should return a status code of 401 (unauthorized)' do
      get '/api/v1/users.json'
      response.status.should == 401
    end
  end
  context 'client is authenticated' do
    before { authenticate_client }
    it 'should return a status code of 200' do
      get 'api/v1/users.json'
      response.status.should == 200
    end
    it 'should return a list of users in JSON as specified in the API contract' do
      get 'api/v1/users.json'
      body = JSON.parse(response.body)
      body.should have_key 'users'

      # Assert presence of authenticated user
      body['users'].length.should == 1
      body['users'].first['id'].should == @user.uuid
      body['users'].first['email'].should == @user.email
      body['users'].first.keys.should include 'created_at'
      body['users'].first.keys.should include 'updated_at'
    end
  end
end


describe 'GET api/v1/users/:id.json' do
  context 'client is not authenticated' do
    it 'should return a status code of 401 (unauthorized)' do
      get '/api/v1/users.json'
      response.status.should == 401
    end
  end
  context 'client is authenticated' do
    before { authenticate_client }
    context 'the user with the specified UUID exists' do
      before do
        @test_user = FactoryGirl.create :user, uuid: 'read-something-for-funs-sake'
        get 'api/v1/users/read-something-for-funs-sake.json'
      end
      it 'should return a status code of 200 (ok)' do
        response.status.should == 200
      end
      it 'should return the user in JSON as specified in the API contract' do
        body = JSON.parse(response.body)
        body.should have_key 'user'
        body['user']['id'].should == @test_user.uuid
        body['user']['email'].should == @test_user.email
        body['user'].keys.should include 'created_at'
        body['user'].keys.should include 'updated_at'
      end
    end
    context 'the user with the specified UUID does not exist' do
      it 'should return a status code of 404 (not found)' do
        get 'api/v1/users/sleds-are-for-suckers.json'
        response.status.should == 404
      end
    end
  end
end


describe 'GET api/v1/users/me.json' do
  context 'client is not authenticated' do
    it 'should return a status code of 401 (unauthorized)' do
      get '/api/v1/users/me.json'
      response.status.should == 401
    end
  end
  context 'client is authenticated' do
    before do
      authenticate_client
      get 'api/v1/users/me.json'
    end
    it 'should return a status code of 200 (ok)' do
      response.status.should == 200
    end
    it 'should return the current user' do
      body = JSON.parse(response.body)
      body.should have_key 'user'
      body['user']['id'].should == @user.uuid
      body['user']['email'].should == @user.email
      body['user'].keys.should include 'created_at'
      body['user'].keys.should include 'updated_at'
    end
  end
end
