class Article < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true
  validates :title, presence: true, length: { minimum: 1 }
  validates :user_id, presence: true
end
