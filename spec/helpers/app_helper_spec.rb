require 'rails_helper'

describe AppHelper do

  let(:app) { create(:app) }

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

  describe '#download_links' do

    before do
      app.languages << create(:language, iso: 'es')
      allow(app).to receive(:id).and_return(1)
    end

    it 'produces links to download translations for 2 languages' do
      expect(helper.download_links(app, :po)).to eq %(<a href="/apps/1/download/en.po">en</a>, <a href="/apps/1/download/es.po">es</a>)
    end
  end
end
