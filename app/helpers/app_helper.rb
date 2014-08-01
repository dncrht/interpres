module AppHelper
  def current_app
    app = App.find_by_id(session[:current_app_id])
    app ? app.name : 'No app selected'
  end

  def download_links(app, format)
    app.languages.map do |language|
      link_to language.iso, download_app_path(app, iso: language.iso, format: format)
    end.join(', ').html_safe
  end
end