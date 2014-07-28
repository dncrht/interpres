require 'rails_helper'

describe Text do

  describe '#translations_available_languages' do

    let(:text) { create(:text) }
    let(:language) { text.app.languages.first }
    let(:translations) { text.translations_available_languages }
    let(:translation) { translations.first }

    context 'with pending translation' do
      it { expect(translations.count).to eq 1 }
      it { expect(translation.text_id).to eq text.id }
      it { expect(translation.language_id).to eq language.id }
      it { expect(translation.literal).to be_nil }
      it { expect(translation.id).to be_nil }
    end

    context 'with actual translation' do
      before { create(:translation, literal: 'Gut!', text: text, language: language) }

      it { expect(translations.count).to eq 1 }
      it { expect(translation.text_id).to eq text.id }
      it { expect(translation.language_id).to eq language.id }
      it { expect(translation.literal).to eq 'Gut!' }
      it { expect(translation.id).not_to be_nil }
    end
  end
end