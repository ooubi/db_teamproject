class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionHelper

  def render_json(status)
    render json: '{"status" :"' + status.to_s + '"}'
  end

  def hello
  	redirect_to ''
  end
end
