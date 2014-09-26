class Student < ActiveRecord::Base
   belongs_to :semester
   has_many :s_in_c
end
