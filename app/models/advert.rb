class Advert < ActiveRecord::Base
  attr_accessible :address, :category_id, :city, :content, :email, :title, :image
  has_attached_file :image, :styles => {:small => "200x200>" },
                    :url  => "/assets/products/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"
  belongs_to :user
  #belongs_to :category

  before_save { |advert| advert.email = email.downcase }

  #validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 3.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX }
  validates :title, presence: true,
                    length: { minimum: 3, maximum: 20 }
  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :city, presence: true,
                   length: {maximum: 20 }
  validates :address, presence: true,
                      length: {maximum: 40 }
  validates :content, presence: true,
                      length: { maximum: 320 }

  default_scope order: 'adverts.created_at DESC'

  def category
    if category_id > 0
      Category.find(category_id).name
    end
  end
end
