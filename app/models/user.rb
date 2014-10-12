class User < ActiveRecord::Base

   belongs_to :role
   has_many :posts

   def self.from_omniauth(auth)
      where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
         user.provider = auth.provider
         user.uid = auth.uid
         user.name = auth.info.name
         user.email = auth.info.email
         user.oauth_token = auth.credentials.token
         user.oauth_expires_at = Time.at(auth.credentials.expires_at)

         # 判斷是否在本校教師名單中
         @teacher = Teacher.find_by(email: user.email)
         if @teacher
            user.role_id = 1
            user.my_role_id = @teacher.id
            user.save! 
         elsif @student
            user.role_id = 2
            user.my_role_id = @student.id
            user.save! 
         else
            user.role_id = 0
         end

      end
   end
end
