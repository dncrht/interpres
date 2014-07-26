require 'rails_helper'

describe ApplicationHelper do

  describe '#errors_bar' do

    let(:without) { double(errors: {}) }
    let(:with) { double(errors: {base: 'error'}) }
    let(:text) { 'Please correct the highlighted fields.' }

    context 'no errors' do

      it { expect(helper.errors_bar(without)).to be_nil }
      it { expect(helper.errors_bar(without, without)).to be_nil }
    end

    context 'errors' do

      it { expect(helper.errors_bar(with)).to have_selector('div.alert.alert-danger', text: text) }
      it { expect(helper.errors_bar(with, without)).to have_selector('div.alert.alert-danger', text: text) }
      it { expect(helper.errors_bar(with, with)).to have_selector('div.alert.alert-danger', text: text) }
    end
  end
end
