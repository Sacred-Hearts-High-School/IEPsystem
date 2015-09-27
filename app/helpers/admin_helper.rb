module AdminHelper
  def statusStr(num)
    case num
      when 50..100 then "<span class=\"glyphicon glyphicon-ok\" aria-hidden=\"true\" style=\"color:green\"></span>"+num.to_s
      when 1..49 then "<span class=\"glyphicon glyphicon-remove\" aria-hidden=\"true\" style=\"color:red\"></span>"+num.to_s
      else num
    end
  end
end
