require './test/test_helper'

class TiumestampTest < Test::Unit::TestCase
  include Mongo

  def test_timestamp_equality
    t1 = Timestamp.new(5000, 200)
    t2 = Timestamp.new(5000, 200)
    assert_equal t2, t1
  end

  def test_timestamp_range
    t = 1;
    while(t < 1_000_000_000 ) do
      ts = Timestamp.new(t, 0)
      doc = {:ts => ts}
      bson = BSON::BSON_CODER.serialize(doc)
      assert_equal doc[:ts], BSON::BSON_CODER.deserialize(bson)['ts']
      t = t * 10
    end
  end

  def test_implements_array_for_backward_compatibility
    silently do
      ts = Timestamp.new(5000, 200)
      assert_equal 200, ts[0]
      assert_equal 5000, ts[1]

      array = ts.map {|t| t }
      assert_equal 2, array.length

      assert_equal 200, array[0]
      assert_equal 5000, array[1]
    end
  end

end
