class App < ActiveRecord::Base
  has_and_belongs_to_many :languages
  has_many :texts

  validates :name, presence: true
end
