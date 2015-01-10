class Comment < ActiveRecord::Base

   belongs_to :teacher
   belongs_to :post

   validates_length_of :content, :minimum=>25

end
