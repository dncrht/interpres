require 'rails_helper'

describe TextsController do

  before do
    ENV['HTTP_USER'] = nil
  end

  context 'no app selected' do
    before { get :index }

    it { expect(response).to redirect_to apps_path }
    it { expect(flash[:notice]).to eq "Select an app from the dropdown to edit its text strings.<br>Don't have an app? Add one!" }
  end

  context 'app selected via token' do

    let(:app) { create(:app, token: '123456') }
    let(:text) { build(:text, app: app) }
    let(:text_attributes) { text.attributes }

    it 'does not create a text if unauthenticated' do
      post :create, params: {text: text_attributes, app_token: 'invalid'}

      expect(response.code).to eq '403'
    end

    it 'creates a text when authenticated' do
      expect {
        post :create, params: {text: text_attributes, app_token: app.token}
      }.to change(Text, :count).by 1
    end
  end

  context 'app selected' do

    let(:app) { create(:app) }

    before do
      session[:current_app_id] = app.id
    end

    context 'with an existing text' do
      let(:text) { create(:text, app: app) }

      describe '#index' do
        before { get :index }

        it { expect(response).to be_success }
        it { expect(assigns(:texts)).to eq [text] }
        it { expect(response).to render_template 'index' }
      end

      describe '#edit' do
        before { get :edit, params: {id: text.id} }

        it { expect(response).to be_success }
        it { expect(assigns(:text)).to eq text }
        it { expect(response).to render_template 'edit' }
      end

      describe '#update' do
        before { patch :update, params: {id: text.id, text: text_attributes} }

        context 'valid text' do
          let(:text_attributes) { text.attributes }

          it { expect(response).to redirect_to texts_path }
        end

        context 'invalid text' do
          let(:text_attributes) { text.attributes.merge('literal' => nil) }

          it { expect(response).to be_success }
          it { expect(assigns(:text)).to eq text }
          it { expect(response).to render_template 'edit' }
        end
      end
    end

    context 'with a new text' do
      let(:text) { build(:text, app: app) }

      describe '#new' do
        before { get :new }

        it { expect(response).to be_success }
        it { expect(assigns(:text)).to be_a Text }
        it { expect(response).to render_template 'new' }
      end

      describe '#create' do
        before { post :create, params: {text: text_attributes} }

        context 'valid text' do
          let(:text_attributes) { text.attributes }

          it { expect(response).to redirect_to texts_path }
        end

        context 'invalid text' do
          let(:text_attributes) { text.attributes.merge('literal' => nil) }

          it { expect(response).to be_success }
          it { expect(assigns(:text)).to be_a Text }
          it { expect(response).to render_template 'new' }
        end
      end
    end
  end
end
