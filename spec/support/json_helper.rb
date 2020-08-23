# frozen_string_literal: true

module JsonHelper
  def response_json
    JSON.parse(response.body)
  end

  def mock_json
    JSON.parse(File.read("spec/support/response/2v2aj48.json"))
  end
end