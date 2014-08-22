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
        out << %("Project-Id-Version: #{@app.name}\\n")
        out << %("POT-Creation-Date: #{Time.current}\\n")
        out << %("PO-Revision-Date: #{Time.current}\\n")
        out << %("Language: #{language.iso}\\n")
        out << %("MIME-Version: 1.0\\n")
        out << %("Content-Type: text/plain; charset=UTF-8\\n")
        out << %("Content-Transfer-Encoding: 8bit\\n")
        out << "\n"
      end.join("\n")
    end

    def body(language)
      @app.texts.order('literal').map do |text|
        translation_literal = text.translations.find_by_language_id(language.id).try(:literal)

        [
          %(msgid "#{escape(text.literal)}"),
          %(msgstr "#{escape(translation_literal)}"\n)
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
