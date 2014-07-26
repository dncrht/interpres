module ApplicationHelper
  def errors_bar(*entities)
    entities = Array(entities)

    if entities.detect { |entity| entity.errors.any? }
      content_tag :div, 'Please correct the highlighted fields.', class: 'alert alert-danger'
    end
  end

  def messages_bar
    if notice
      content_tag :div, notice.html_safe, class: 'alert alert-success'
    elsif alert
      content_tag :div, alert.html_safe, class: 'alert alert-warning'
    end
  end
end
