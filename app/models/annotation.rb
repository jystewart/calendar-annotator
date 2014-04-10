class Annotation < ActiveRecord::Base
  belongs_to :user

  validates :event_id, uniqueness: { scope: :user_id }
end
