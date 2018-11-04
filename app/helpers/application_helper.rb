module ApplicationHelper
    def full_title(page_title)
        base_title = "MY EC-SHOP"
      if page_title.empty?
          base_title
      else
        "#{page_title} | #{base_title}"
      end
    end
    
    def bootstrap_class_for(flash_type)
      case flash_type
        when "success"
          "success"
        when "error"
          "danger"
        when "alert"
          "warning"
        when "notice"
          "info"
        else
          flash_type.to_s
      end
    end
end
