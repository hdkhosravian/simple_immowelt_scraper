require 'rails_helper'

RSpec.describe Scraper do
  it "successful request" do
    stub_immowelt
    response = Scraper.new('https://www.immowelt.de/expose/2v2aj48').process

    expect(JSON.parse(response.to_json)).to eq(mock_json)
  end

  context "unsuccessful request" do
    it "nil url" do
      expect {
        Scraper.new(nil).process
      }.to raise_error(TypeError)
    end

    it "empty url" do
      expect {
        Scraper.new('').process
      }.to raise_error(Errno::ENOENT)
    end
  end
end
