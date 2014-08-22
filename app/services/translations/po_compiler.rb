module Translations
  class PoCompiler

    def initialize(app)
      @app = app
    end

    def for_language(language)
      [].tap do |out|
        out << header(language)
        out << body(language)
      end.join("\n")
    end

    def header(language)
      [].tap do |out|
        out << 'msgid ""'
        out << 'msgstr ""'
        out << "Project-Id-Version: #{@app.name}"
        out << "POT-Creation-Date: #{Time.current}"
        out << "PO-Revision-Date: #{Time.current}"
        out << "Language: #{language.iso}"
        out << 'MIME-Version: 1.0'
        out << 'Content-Type: text/plain; charset=UTF-8'
        out << 'Content-Transfer-Encoding: 8bit'
        out << "\n"
      end.join("\n")
    end

    def body(language)
      @app.texts.order('literal').map do |text|
        translation_literal = text.translations.find_by_language_id(language.id).try(:literal)

        [
          %(msgid "#{escape(text.literal)}"),
          %(msgid "#{escape(translation_literal)}"\n)
        ]
      end.flatten.join("\n")
    end

    private

    def escape(str)
      return unless str
      str.gsub '"', '\"'
    end
  end
end
