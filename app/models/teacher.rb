class Teacher < ActiveRecord::Base
   has_many :t_in_c, inverse_of: teacher
end
