class Category < ActiveRecord::Base
  @@types = [["Fashion", 1], ["Parts & accessories", 2], ["Electronics", 3], ["Collectibles & art", 4],
                    ["Home, outdoors & decor", 5], ["Entertainment", 6], ["TV, Video & Audio", 7],
                    ["Women's Clothing", 8], ["Jewelry & Watches", 9]]
  cattr_reader :types
  attr_accessible :name

  #has_many :adverts, dependent: :destroy

  validates :name, presence: true,
                   uniqueness: true

  def self.array
    arr = []
    Category.all.each do |c|
      arr << [c.name, c.id]
    end
    arr
  end
end
