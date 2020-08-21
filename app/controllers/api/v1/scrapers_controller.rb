# frozen_string_literal: true
module Api
  module V1
    class ScrapersController < Api::V1::ApiController
      def show
        param! :url, String, required: true, blank: false

        result = Scraper.new(params[:url]).process

        render json: JSON.parse(result.to_json), status: :ok
      end
    end
  end
end
