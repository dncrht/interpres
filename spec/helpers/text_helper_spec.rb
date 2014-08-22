require 'rails_helper'

describe TextHelper do

  let(:translation) { create(:translation) }
  let(:text) { translation.text }

  describe '#available_translations' do

    it 'returns the iso code of the available translations' do
      expect(helper.available_translations(text)).to eq 'en'
    end
  end
end
