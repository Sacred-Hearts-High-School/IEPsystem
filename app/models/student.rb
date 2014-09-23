class Student < ActiveRecord::Base
   belongs_to :semester
   has_many :s_in_c, inverse_of: :student
end
