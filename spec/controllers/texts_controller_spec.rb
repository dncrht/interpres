require 'rails_helper'

describe TextsController do

  context 'no app selected' do
    before { get :index }

    it { expect(response).to redirect_to apps_path }
    it { expect(flash[:notice]).to eq "Select an app from the dropdown to edit its text strings.<br>Don't have an app? Add one!" }
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
        before { get :edit, id: text.id }

        it { expect(response).to be_success }
        it { expect(assigns(:text)).to eq text }
        it { expect(response).to render_template 'edit' }
      end

      describe '#update' do
        before { put :update, id: text.id, text: text_attributes }

        context 'valid text' do
          let(:text_attributes) { text.attributes }

          it { expect(response).to redirect_to texts_path }
        end

        context 'invalid text' do
          let(:text_attributes) { text.attributes.merge(literal: nil) }

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
        before { post :create, text: text_attributes }

        context 'valid text' do
          let(:text_attributes) { text.attributes }

          it { expect(response).to redirect_to texts_path }
        end

        context 'invalid text' do
          let(:text_attributes) { text.attributes.merge(literal: nil) }

          it { expect(response).to be_success }
          it { expect(assigns(:text)).to be_a Text }
          it { expect(response).to render_template 'new' }
        end
      end
    end
  end
end
