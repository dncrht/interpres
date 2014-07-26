module ApplicationHelper
  def errors_bar(*entities)
    entities = Array(entities)

    if entities.detect { |entity| entity.errors.any? }
      content_tag :div, 'Please correct the highlighted fields.', class: 'alert alert-danger'
    end
  end
end
