# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound do |exception|
    raise ActionController::RoutingError.new('Not Found')
  end
end
