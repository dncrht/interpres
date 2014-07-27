class App < ActiveRecord::Base
  has_and_belongs_to_many :languages

  validates :name, presence: true
end
