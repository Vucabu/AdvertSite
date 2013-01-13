class Role < ActiveRecord::Base
  @@types = [["Admin", 1], ["User", 2]]
  cattr_reader :types

  attr_accessible :name
  has_many :users

  validates :name, presence: true,
                   uniqueness: true
end
