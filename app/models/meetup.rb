class Meetup <ActiveRecord::Base
  has_many :memberships
  has_many :comments
  has_many :users, through: :memberships
end
