module ApplicationHelper

   def user_menu
      case 
      when current_user.nil?
         "<li><a href=\"/auth/google_oauth2\">本校教師登入</a></li>".html_safe
      when current_user.is_admin
        "<li><a href=\"/semesters\">學期資料管理</a></li>
         <li><a href=\"/teachers\">教師資料管理</a></li>
         <li><a href=\"/students\">學生資料管理</a></li>
         <li><a href=\"/classrooms\">班級資料管理</a></li>
         <li><a href=\"/admin/posts\">張貼文章管理</a></li>
         <li><a href=\"/attachments\">各式檔案管理</a></li>
         <li><a href=\"/admin/menu\">管理者選單</a></li>
         <li><a href=\"/signout\">登出系統</a></li>".html_safe
      when current_user
         "<li><a href=\"/posts\">查看文章</a></li>
         <li><a href=\"/tasks/my\">查看#{current_user.name}的任務</a></li>
         <li><a href=\"/signout\">登出系統</a></li>".html_safe
      else
         "<li><a href=\"/auth/google_oauth2\">本校教師登入</a></li>".html_safe
      end
   end

   # --------------- For flexible theme, from: ------------------------------
   # http://rvg.me/2013/11/adding-a-bootstrap-3-layout-to-a-rails-4-project/
   

  def site_name
    # Change the value below between the quotes.
    "正心中學特教組"
  end

  def site_url
    if Rails.env.production?
      # Place your production URL in the quotes below
      "http://special.shsh.ylc.edu.tw:8080"
    else
      # Our dev & test URL
      "http://special.shsh.ylc.edu.tw:8080"
    end
  end

  def meta_author
    # Change the value below between the quotes.
    "詹嘉隆"
  end

  def meta_description
    # Change the value below between the quotes.
    "這是一個用 Ruby on Rails 4 刻出來的特教組網站"
  end

  def meta_keywords
    # Change the value below between the quotes.
    "學校 身心障礙 音樂班 資優"
  end

  # Returns the full title on a per-page basis.
  # No need to change any of this we set page_title and site_name elsewhere.
  def full_title(page_title)
    if page_title.empty?
      site_name
    else
      "#{page_title} | #{site_name}"
    end
  end

  def flash_class(level)
     case level
     when :notice then "alert alert-info"
     when :success then "alert alert-success"
     when :error then "alert alert-danger"
     when :warning then "alert alert-warning"
     end
  end

end



