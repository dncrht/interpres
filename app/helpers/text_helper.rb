module TextHelper
  def available_translations(text)
    text.translations.map do |translation|
      translation.language.iso if translation.literal.present?
    end.uniq.join "\n"
  end
end