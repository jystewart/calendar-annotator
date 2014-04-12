if ENV['WITH_SERVER'] == 'true'
  start_sinatra_app(:port => 7777) do
    get('/:path') { "Hello #{params[:path]}" }
  end
end

require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir     = 'features/cassettes'
  c.default_cassette_options = { :record => :new_episodes }
end

VCR.cucumber_tags do |t|
  t.tag  '@localhost_request' # uses default record mode since no options are given
  t.tags '@disallowed_1', '@disallowed_2', :record => :none
end