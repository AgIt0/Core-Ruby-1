require 'minitest/autorun'

require_relative 'solution'

class HashTest < Minitest::Test
  def test_pick
    assert_equal({ a: 1, b: 2 }, { a: 1, b: 2, c: 3 }.pick(:a, :b))
  end

  def test_except
    assert_equal({ a: 1, b: 2 }, { a: 1, b: 2, d: nil }.except(:d))
  end

  def test_compact_values
    assert_equal({ a: 1, b: 2 }, { a: 1, b: 2, d: nil }.compact_values)
  end

  def test_defaults
    assert_equal({ a: 1, b: 2, c: 3 }, { a: 1, b: 2 }.defaults(a: 4, c: 3))
  end

  def test_values_map
    assert_equal({ a: 4, b: 9 },
                 { a: 2, b: 3 }.values_map { |x| x**2 })
  end

  def test_pick!
    hash = { a: 1, b: 2, c: 3 }
    assert_equal(hash.object_id,
                 hash.pick!(:a, :b).object_id)
  end

  def test_except!
    hash = { a: 1, b: 2, d: nil }
    assert_equal(hash.object_id,
                 hash.except!(:d).object_id)
  end

  def test_compact_values!
    hash = { a: 1, b: 2, d: nil }
    assert_equal(hash.object_id,
                 hash.compact_values!.object_id)
  end

  def test_defaults!
    hash = { a: 1, b: 2, c: 3 }
    assert_equal(hash.object_id,
                 hash.defaults!(a: 4, c: 3).object_id)
  end
end
