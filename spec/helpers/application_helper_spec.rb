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

  describe '#messages_bar' do

    it 'shows nothing' do
      expect(helper.messages_bar).to be_nil
    end

    it 'shows notice' do
      text = 'Success!'
      flash[:notice] = text
      expect(helper.messages_bar).to have_selector('div.alert.alert-success', text: text)
    end

    it 'shows alert' do
      text = 'Oopsy!'
      flash[:alert] = text
      expect(helper.messages_bar).to have_selector('div.alert.alert-warning', text: text)
    end

    it 'shows notice when provided both' do
      text = 'Success!'
      flash[:notice] = text
      flash[:alert] = 'Oopsy!'
      expect(helper.messages_bar).to have_selector('div.alert.alert-success', text: text)
    end
  end
end
