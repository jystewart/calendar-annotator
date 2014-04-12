require 'net/http'

When /^a request is made to "([^"]*)"$/ do |url|
  @response = Net::HTTP.get_response(URI.parse(url))
end

When /^(.*) within a cassette named "([^"]*)"$/ do |step, cassette_name|
  VCR.use_cassette(cassette_name) { When step }
end

Then /^the response should be "([^"]*)"$/ do |expected_response|
  @response.body.should == expected_response
end
