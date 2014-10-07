class Task < ActiveRecord::Base
   belongs_to :classroom
   belongs_to :student
   belongs_to :teacher
   belongs_to :post

   # 產生唯一 token 的方法：
   # http://stackoverflow.com/questions/6021372/best-way-to-create-unique-token-in-rails
   include Tokenable
end
