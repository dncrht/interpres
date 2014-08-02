class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :basic_auth, :available_apps

  private

  def basic_auth
    return if ENV['HTTP_USER'].blank?

    authenticate_or_request_with_http_basic do |user, password|
      user == ENV['HTTP_USER'] && password == ENV['HTTP_PASSWORD']
    end
  end

  def available_apps
    @apps = App.all
  end
end
