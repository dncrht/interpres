require 'rails_helper'

describe LanguagesController do

  before do
    ENV['HTTP_USER'] = nil
  end

  context 'with an existing language' do
    let(:language) { create(:language) }

    describe '#index' do
      before { get :index }

      it { expect(response).to be_success }
      it { expect(assigns(:languages)).to eq [language] }
      it { expect(response).to render_template 'index' }
    end

    describe '#edit' do
      before { get :edit, id: language.id }

      it { expect(response).to be_success }
      it { expect(assigns(:language)).to eq language }
      it { expect(response).to render_template 'edit' }
    end

    describe '#update' do
      before { put :update, id: language.id, language: language_attributes }

      context 'valid language' do
        let(:language_attributes) { language.attributes }

        it { expect(response).to redirect_to languages_path }
      end

      context 'invalid language' do
        let(:language_attributes) { language.attributes.merge(name: nil) }

        it { expect(response).to be_success }
        it { expect(assigns(:language)).to eq language }
        it { expect(response).to render_template 'edit' }
      end
    end
  end

  context 'with a new language' do
    let(:language) { build(:language) }

    describe '#new' do
      before { get :new }

      it { expect(response).to be_success }
      it { expect(assigns(:language)).to be_a Language }
      it { expect(response).to render_template 'new' }
    end

    describe '#create' do
      before { post :create, language: language_attributes }

      context 'valid language' do
        let(:language_attributes) { language.attributes }

        it { expect(response).to redirect_to languages_path }
      end

      context 'invalid language' do
        let(:language_attributes) { language.attributes.merge(name: nil) }

        it { expect(response).to be_success }
        it { expect(assigns(:language)).to be_a Language }
        it { expect(response).to render_template 'new' }
      end
    end
  end
end
