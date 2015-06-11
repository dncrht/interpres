module ApplicationHelper
  def current_app
    app = App.find_by_id(session[:current_app_id])
    app ? app.name : 'No app selected'
  end
end
