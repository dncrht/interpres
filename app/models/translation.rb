class Translation < ActiveRecord::Base
  belongs_to :text
  belongs_to :language

  def literal=(value)
    value.strip! if value
    super
  end
end
