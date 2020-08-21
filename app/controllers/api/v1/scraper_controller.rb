# frozen_string_literal: true
module Api
  module V1
    class ScraperController < Api::V1::ApiController
      def show
        param! :url, String, required: true, blank: false
      end
    end
  end
end
