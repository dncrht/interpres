class ApplicationController < ActionController::Base
  before_action :basic_auth, :available_apps

  helper Sal::ApplicationHelper

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
