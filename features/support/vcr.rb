require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir     = 'features/cassettes'
  c.default_cassette_options = { :record => :new_episodes }
end

VCR.cucumber_tags do |t|
  t.tag '@localhost_request' # uses default record mode since no options are given
  t.tags '@successful_calendar_list', '@todays_event_list',
    :record => :none, :match_requests_on => [:path],
    :allow_playback_repeats => true
  t.tags '@disallowed_1', '@disallowed_2', :record => :none
end