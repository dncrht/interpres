require 'rails_helper'

describe AppsController do

  before do
    ENV['HTTP_USER'] = nil
  end

  context 'app selected via token' do
    let!(:app) { create(:app, token: '123456') }

    it 'returns 403 if unauthenticated' do
      get :enabled_languages, app_token: 'invalid'

      expect(response.code).to eq '403'
    end

    it 'returns app languages when authenticated' do
      get :enabled_languages, app_token: app.token

      expect(response.body).to eq '["en"]'
    end
  end

  context 'with an existing app' do
    let(:app) { create(:app) }

    describe '#index' do
      before { get :index }

      it { expect(response).to be_success }
      it { expect(assigns(:apps)).to eq [app] }
      it { expect(response).to render_template 'index' }
    end

    describe '#edit' do
      before { get :edit, id: app.id }

      it { expect(response).to be_success }
      it { expect(assigns(:app)).to eq app }
      it { expect(response).to render_template 'edit' }
    end

    describe '#set' do
      before { get :set, id: app.id }

      it { expect(session[:current_app_id]).to eq app.id.to_s }
      it { expect(response).to redirect_to apps_path }
    end

    describe '#download' do
      before { get :download, id: app.id, iso: 'en', format: :po }

      it { expect(response).to be_success }
      it { expect(response.header['Content-Disposition']).to eq %(attachment; filename="en.po") }
    end

    describe '#create_token' do
      before { patch :create_token, id: app.id }

      it { expect(flash[:show_token]).to be_truthy }
      it { expect(app.reload.token).to be_present }
      it { expect(response).to redirect_to apps_path }
    end

    describe '#update' do
      before { put :update, id: app.id, app: app_attributes }

      context 'valid app' do
        let(:app_attributes) { app.attributes }

        it { expect(response).to redirect_to apps_path }
      end

      context 'valid app with language' do
        let(:language) { app.languages.first }
        let(:app_attributes) { app.attributes.merge(languages: language.id) }

        it { expect(response).to redirect_to apps_path }
        it { expect(app.languages).to eq [language] }
      end

      context 'invalid app' do
        let(:app_attributes) { app.attributes.merge(name: nil) }

        it { expect(response).to be_success }
        it { expect(assigns(:app)).to eq app }
        it { expect(response).to render_template 'edit' }
      end
    end
  end

  context 'with a new app' do
    let(:app) { build(:app) }

    describe '#new' do
      before { get :new }

      it { expect(response).to be_success }
      it { expect(assigns(:app)).to be_an App }
      it { expect(response).to render_template 'new' }
    end

    describe '#create' do
      let(:created_app) { App.find_by_name(app_attributes['name']) }

      before { post :create, app: app_attributes }

      context 'valid app' do
        let(:app_attributes) { app.attributes }

        it { expect(response).to redirect_to apps_path }
      end

      context 'valid app with language' do
        let(:language) { create(:language) }
        let(:app_attributes) { app.attributes.merge(languages: language.id) }

        it { expect(response).to redirect_to apps_path }
        it { expect(created_app.languages).to eq [language] }
      end

      context 'invalid app' do
        let(:app_attributes) { app.attributes.merge(name: nil) }

        it { expect(response).to be_success }
        it { expect(assigns(:app)).to be_an App }
        it { expect(response).to render_template 'new' }
      end
    end
  end
end
