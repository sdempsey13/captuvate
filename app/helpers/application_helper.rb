module ApplicationHelper
  include PathUtils

  def flash_message(type)
    return unless flash[type].present?
    
    content_tag(:p, flash[type], class: ['alert', 'alert-primary'])
  end

  def bootstrap_class_for(flash_type)
    case flash_type.to_sym
    when :notice then "alert-info"
    when :success then "alert-success"
    when :error then "alert-danger"
    when :alert then "alert-warning"
    else "alert-primary"
    end
  end  
end
