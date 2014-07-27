require 'rails_helper'

describe AppsController do

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

    describe '#update' do
      before { put :update, id: app.id, app: app_attributes }

      context 'valid app'  do
        let(:app_attributes) { app.attributes }

        it { expect(response).to redirect_to apps_path }
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
      before { post :create, app: app_attributes }

      context 'valid app' do
        let(:app_attributes) { app.attributes }

        it { expect(response).to redirect_to apps_path }
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
