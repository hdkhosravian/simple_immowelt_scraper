require 'rails_helper'

RSpec.describe Api::V1::ScrapersController, type: :controller do
  it "successful request" do
    stub_immowelt
    get :show, params: { url: 'https://www.immowelt.de/expose/2v2aj48' }

    expect(response).to have_http_status(200)
    expect(response_json).to eq(mock_json)
  end

  context "unsuccessful request" do
    it "without url" do
      get :show
      expect(response).to have_http_status(400)
      expect(response_json["detail"]).to eq('Parameter url is required')
    end

    it "nil url" do
      get :show, params: { url: nil }
      expect(response).to have_http_status(400)
      expect(response_json["detail"]).to eq('Parameter url cannot be blank')
    end

    it "empty url" do
      get :show, params: { url: '' }
      expect(response).to have_http_status(400)
      expect(response_json["detail"]).to eq('Parameter url cannot be blank')
    end

    it "invalid url" do
      get :show, params: { url: 'invalid url' }
      expect(response).to have_http_status(400)
      expect(response_json["detail"]).to eq(I18n.t('errors.invalid_url'))
    end
  end
end
