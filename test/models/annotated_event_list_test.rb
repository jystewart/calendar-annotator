require 'test_helper'
require 'annotated_event_list'

class AnnotatedEventListTest < ActiveSupport::TestCase

  EVENT_LIST = [
    {
      'id' => 1,
      'summary' => 'Cancelled event',
      'status' => 'cancelled'
    },
    {
      'id' => 2,
      'summary' => 'All day event',
      'status' => 'confirmed',
      'start' => {
        'date' => "2014-02-02"
      }
    },
    {
      'id' => 3,
      'summary' => 'Other event',
      'status' => 'confirmed',
      'start' => {
        'dateTime' => '2014-02-02T13:00:00Z'
      }
    },
    {
      'id' => 4,
      'summary' => "Event without date",
      'status' => 'confirmed'
    }
  ]

  ANNOTATIONS = [
    Annotation.new(event_id: 2, notes: 'An existing note')
  ]

  test "it filters out cancelled events" do
    a = AnnotatedEventList.new(EVENT_LIST, [])
    assert_nil a.detect { |e| e[:event]['summary'] == 'Cancelled event' }
  end

  test "events without dates come first in the list" do
    a = AnnotatedEventList.new(EVENT_LIST, [])
    assert_equal 'Event without date', a.first[:event]['summary']
  end

  test "all day events come next in the list" do
    a = AnnotatedEventList.new(EVENT_LIST, [])
    assert_equal 'All day event', a[1][:event]['summary']
  end

  test "it assigns annotations to all events" do
    a = AnnotatedEventList.new(EVENT_LIST, ANNOTATIONS)
    a.each do |event|
      assert event[:annotation]
    end
  end

  test "it combines existing annotations with relevant events" do
    a = AnnotatedEventList.new(EVENT_LIST, ANNOTATIONS)
    matched = a.detect { |event| event[:event]['id'] == ANNOTATIONS.first.event_id}
    assert_equal 'An existing note', matched[:annotation][:notes]
  end

  test "it creates new annotations where there aren't any" do
    a = AnnotatedEventList.new(EVENT_LIST, ANNOTATIONS)
    matched = a.reject { |event| event[:event]['id'] == ANNOTATIONS.first.event_id}
    matched.each do |event|
      assert_nil event[:annotation][:notes]
    end
  end
end
