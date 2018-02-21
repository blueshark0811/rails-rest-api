class ApplicationController < ActionController::Base
  include SharedController
  protect_from_forgery with: :exception
end
