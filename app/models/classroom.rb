class Classroom < ActiveRecord::Base
   belongs_to :semester
   has_many :s_in_c
   has_many :t_in_c
end
