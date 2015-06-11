module AppHelper
  def download_links(app, format)
    app.languages.map do |language|
      link_to language.iso, download_app_path(app, iso: language.iso, format: format)
    end.join(', ').html_safe
  end

  def show_token(app)
    if flash[:show_token]
      render partial: 'apps/token', locals: {app: app}
    else
      link_to 'Generate a new token for the app', token_app_path(app), method: :patch
    end
  end
end
