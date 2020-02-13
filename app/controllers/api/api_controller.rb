# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    protect_from_forgery with: :null_session, unless: -> { request.format.json? }

    rescue_from StandardError do |exception|
      render json: { error: exception.message }, status: 500
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
      render json: { error: exception.message }, status: 404
    end
  end
end
