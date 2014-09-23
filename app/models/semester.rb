class Semester < ActiveRecord::Base
   has_many :classrooms
   has_many :students
end
