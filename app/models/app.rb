class App < ActiveRecord::Base
  has_and_belongs_to_many :languages
  has_many :texts

  validates :name, presence: true

  def self.find_by_token(token)
    return unless token
    App.find(token: token)
  end
end
