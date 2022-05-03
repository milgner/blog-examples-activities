require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'it has many activities' do
    relation = User.reflect_on_association(:activities)
    assert(relation.collection?)
  end
end
