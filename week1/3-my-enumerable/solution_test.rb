require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
  class Collection
    include MyEnumerable

    def initialize(*data)
      @data = data
    end

    def each(&block)
      @data.each(&block)
    end

    def each_with_index(&block)
      @data.each_with_index(&block)
    end
  end

  def test_map
    collection = Collection.new(*1..5)

    assert_equal [2, 3, 4, 5, 6], collection.map(&:succ)
  end

  def test_filter
    collection = Collection.new(*1..10)

    assert_equal [1, 3, 5, 7, 9], collection.filter(&:odd?)
  end

  def test_reject
    collection = Collection.new(*1..10)

    assert_equal [1, 3, 5, 7, 9], collection.reject(&:even?)
  end

  def test_reduce
    collection = Collection.new(*1..10)

    assert_equal 55, collection.reduce(0) { |a, e| a + e }
  end

  def test_include?
    collection = Collection.new(*1..10)

    assert_equal true, collection.include?(5)
    assert_equal false, collection.include?(11)
  end

  def test_any?
    collection = Collection.new([true, false])
    collection1 = Collection.new(*1..5)

    assert_equal true, collection.any?
    assert_equal true, collection1.any? { |x| x < 5 }
    assert_equal false, collection1.any? { |x| x > 5 }
  end

  def test_all?
    collection = Collection.new(2, 4, 6)
    nil_collection = Collection.new(nil, true)

    assert_equal true, collection.all?
    assert_equal false, nil_collection.all?
  end

  def test_size
    collection = Collection.new(*1..5)

    assert_equal 5, collection.size
  end

  def test_count
    collection = Collection.new(nil, nil, nil, false)

    assert_equal 3, collection.count(nil)
  end

  def test_each_cons
    collection = Collection.new(*1..10)

    assert_equal [[1, 2, 3], [2, 3, 4], [3, 4, 5], [4, 5, 6], [5, 6, 7],
                  [6, 7, 8], [7, 8, 9], [8, 9, 10]],
                 collection.each_cons(3)
  end

  def test_group_by
    collection = Collection.new(*1..6)

    assert_equal ({ 0 => [3, 6], 1 => [1, 4], 2 => [2, 5] }),
                 collection.group_by { |i| i % 3 }
    assert_equal ({ 1 => [1], 2 => [2], 3 => [3], 4 => [4], 5 => [5], 6 => [6] }),
                 collection.group_by { |i| i }
  end

  def test_min
    collection = Collection.new(*%w(albatross dog horse))

    assert_equal 'albatross', collection.min
    assert_equal 'dog', collection.min { |a, b| a.length <=> b.length }
  end

  def test_min_by
    collection = Collection.new(*%w(albatross dog horse))

    assert_equal 'dog', collection.min_by(&:length)
  end

  def test_max
    collection = Collection.new(*%w(albatross dog horse))

    assert_equal 'horse', collection.max
    assert_equal 'albatross', collection.max { |a, b| a.length <=> b.length }
  end

  def test_max_by
    collection = Collection.new(*%w(albatross dog horse))

    assert_equal 'albatross', collection.max_by(&:length)
  end

  def test_minmax
    collection = Collection.new(*%w(albatross dog horse))

    assert_equal %w(albatross horse), collection.minmax
    assert_equal %w(dog albatross),
                 collection.minmax { |a, b| a.length <=> b.length }
  end

  def test_minmax_by
    collection = Collection.new(*%w(albatross dog horse))

    assert_equal %w(dog albatross), collection.minmax_by(&:length)
  end

  def test_take
    collection = Collection.new(*1..5)

    assert_equal [1, 2, 3], collection.take(3)
  end

  def test_take_while
    collection = Collection.new(*1..5)

    assert_equal [1, 2], collection.take_while { |i| i < 3 }
  end

  def test_drop
    collection = Collection.new(*1..5)

    assert_equal [4, 5], collection.drop(3)
  end

  def test_drop_while
    collection = Collection.new(*1..5)

    assert_equal [3, 4, 5], collection.drop_while { |i| i < 3 }
  end
end
