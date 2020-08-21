class ApplicationController < ActionController::API
  include ErrorHandlers::BadRequestError
end
