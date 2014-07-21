class Translation < ActiveRecord::Base
  belongs_to :text
  belongs_to :language
end
