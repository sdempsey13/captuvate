module ApplicationHelper
  def flash_message(type)
    return unless flash[type].present?
    
    content_tag(:p, flash[type], class: ['alert', 'alert-primary'])
  end
end
