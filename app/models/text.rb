class Text < ActiveRecord::Base
  belongs_to :app
  has_many :translations

  validates :literal, presence: true
  validates :literal, uniqueness: {scope: :app_id}

  def translations_available_languages
    app.languages.by_iso.map do |language|
      translations.find_by_language_id(language.id) || translations.build(language_id: language.id)
    end
  end
end
