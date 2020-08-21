# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Api::V1::ScrapersController, type: :routing do
  it 'GET api_v1_scrapers' do
    expect(get: '/api/v1/scrapers').to route_to(controller: 'api/v1/scrapers', action: 'show')
  end
end