module ApplicationHelper
  def error_alert(entity)
    if entity.errors.any?
      content_tag :div, 'Please correct the highlighted fields.', class: 'alert alert-danger'
    end
  end
end
