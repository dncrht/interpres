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

  describe '#menu_item' do
    subject { helper.menu_item(item) { 'content' } }

    before do
      allow(helper).to receive(:section) { 'selected_list_item' }
    end

    context 'list item is selected' do
      let(:item) { 'selected_list_item' }

      it { is_expected.to have_selector('li.active', 'content') }
    end

    context 'list item is not selected' do
      let(:item) { 'unselected_list_item' }

      it { is_expected.to_not have_selector('li.active') }
      it { is_expected.to have_selector('li', 'content') }
    end
  end
end
