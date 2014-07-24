require 'rails_helper'

describe ApplicationHelper do

  describe '#error_alert' do
    subject { helper.error_alert(entity) }

    context 'no errors' do
      let(:entity) { double(errors: {}) }

      it { expect(subject).to be_nil }
    end

    context 'errors' do
      let(:entity) { double(errors: {base: 'error'}) }

      it { expect(subject).to have_selector('div.alert.alert-danger', 'Please correct the highlighted fields.') }
    end
  end
end
