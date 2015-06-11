require 'rails_helper'

describe ApplicationHelper do

  let(:app) { create(:app, token: '123456') }

  describe '#current_app' do

    it 'cannot find an app' do
      session[:current_app_id] = nil
      expect(helper.current_app).to eq 'No app selected'
    end

    it 'returns the app we currently work with' do
      session[:current_app_id] = app.id
      expect(helper.current_app).to eq app.name
    end
  end
end
