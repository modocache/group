class Post < ActiveRecord::Base
  include HasUuid

  attr_accessible :user, :title, :body
  default_scope order 'created_at DESC'

  belongs_to :user

  validates :user, presence: true
  validates :title, presence: true,
                    uniqueness: { scope: :user_id }
  validates :body, presence: true
end
