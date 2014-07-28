class Language < ActiveRecord::Base
  has_and_belongs_to_many :apps

  scope :by_iso, -> { order('iso') }

  validates :name, :iso, presence: true
end
