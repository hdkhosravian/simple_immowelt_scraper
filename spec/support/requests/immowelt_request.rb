module ImmoweltRequest
  def stub_immowelt
    stub_request(:get, "https://www.immowelt.de/expose/2v2aj48").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Ruby'
      }).
    to_return(status: 200, body: File.read("spec/support/requests/immowelt.html"), headers: {})
  end
end