require 'rails_helper'

describe ApplicationController do

  context 'without auth' do
    it 'goes to root path' do
      ENV['HTTP_USER'] = nil

      get apps_path

      expect(response).to be_success
    end
  end

  context 'with auth' do

    it 'throws error with wrong credentials' do
      ENV['HTTP_USER'] = 'wrong'

      get apps_path

      expect(response.code).to eq '401'
    end

    it 'goes to root path' do
      ENV['HTTP_USER'] = 'right'
      ENV['HTTP_PASSWORD'] = '123456'
      basic_auth = ActionController::HttpAuthentication::Basic.encode_credentials ENV['HTTP_USER'], ENV['HTTP_PASSWORD']

      get apps_path, headers: {'HTTP_AUTHORIZATION' => basic_auth}

      expect(response).to be_success
    end
  end
end
