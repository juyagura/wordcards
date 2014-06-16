class Card < ActiveRecord::Base

  belongs_to :user

  validates :word, :presence => true, :uniqueness => { :scope => :user_id }

end
