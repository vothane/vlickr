module Commentable
   extend ActiveSupport::Concern

   included do
      has_many :comments, as: :commentable
   end

   def comments_by_user(id)
      comments.where(user_id: id)
   end
end