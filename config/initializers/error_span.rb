ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  message = Array(instance.error_message).join(', ')

  if html_tag =~ /class="checkbox"/ || ((html_tag !~ /type="checkbox"/) && (html_tag !~ /label/))
    %(<div class="has-error">#{html_tag}<span class="help-block">⤷ #{message}</span></div>).html_safe
  else
    %(<div class="has-error">#{html_tag}</div>).html_safe
  end
end
