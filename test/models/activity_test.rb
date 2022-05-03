require "test_helper"

class ActivityTest < ActiveSupport::TestCase
  test 'it belongs to an user' do
    relation = Activity.reflect_on_association(:user)
    assert(relation)
    assert_not(relation.collection?)
  end

  test 'it has a distance' do
    activity = Activity.new(distance: 1000)
    assert_kind_of(Distance, activity.distance)
    assert_equal(0.6213712, activity.distance.miles)
  end

  test 'it can sum distances' do
    user = users(:marcus)
    total = user.activities.sum(:distance)
    assert_kind_of(Distance, total)
    assert_equal(total, 3000.meters)
  end
end
