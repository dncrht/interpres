require 'rails_helper'

describe Translations::PoCompiler do

  let(:en) { create(:language) }
  let(:es) { create(:language, iso: 'es') }
  let(:app) { create(:app, name: 'Interpres', languages: [en, es]) }

  describe '#for_language' do

    subject { described_class.new(app).for_language(en) }

    let(:text1) { create(:text, literal: 'text"1"', app: app) }
    let(:text2) { create(:text, literal: 'text2', app: app) }
    let!(:translation1) { create(:translation, literal: 'translation"1"', text: text1, language: en) }
    let!(:translation2) { create(:translation, literal: 'translation2', text: text2, language: es) }

    it 'produces expected output' do
      fixed_time = Time.parse('2014-07-31 21:29:49 UTC')
      allow(Time).to receive(:current).and_return(fixed_time)
      expect(subject).to eq <<-EOF
msgid ""
msgstr ""
"Project-Id-Version: Interpres\\n"
"POT-Creation-Date: 2014-07-31 21:29:49 UTC\\n"
"PO-Revision-Date: 2014-07-31 21:29:49 UTC\\n"
"Language: en\\n"
"MIME-Version: 1.0\\n"
"Content-Type: text/plain; charset=UTF-8\\n"
"Content-Transfer-Encoding: 8bit\\n"


msgid "text\\"1\\""
msgstr "translation\\"1\\""

msgid "text2"
msgstr ""
EOF
    end
  end
end
