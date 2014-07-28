class TextTranslationsCreation

  def initialize(text)
    @text = text
  end

  def save_with_translations(translations)
    if @text.save
      create_translations(Array(translations))
      true
    else
      false
    end
  end

  def create_translations(translations)
    @text.app.languages.by_iso.each_with_index do |language, index|
      if translation = @text.translations.find_by_language_id(language.id)
        translation.update(literal: translations[index])
      else
        @text.translations.create(language_id: language.id, literal: translations[index])
      end
    end
  end
end