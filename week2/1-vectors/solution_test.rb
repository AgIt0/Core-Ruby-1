require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
  def test_2d_e
    assert_equal '1:0', Vector2D.e.to_s
  end

  def test_2d_j
    assert_equal '0:1', Vector2D.j.to_s
  end

  def test_2d_length
    assert_equal 1, Vector2D.e.length
    assert_equal 1, Vector2D.j.length
  end

  def test_2d_normalize
    assert_equal Vector2D.e.normalize, Vector2D.e
    assert_equal Vector2D.new(1, 1).normalize,
                 Vector2D.new(0.7071067811865475, 0.7071067811865475)
  end

  def test_2d_equals
    assert_equal Vector2D.e, Vector2D.e
  end

  def test_2d_addition
    assert_equal Vector2D.new(1, 1),
                 Vector2D.e + Vector2D.j
  end

  def test_2d_addition
    assert_equal Vector2D.new(0, 0),
                 Vector2D.e - Vector2D.e
  end

  def test_2d_multiplicaiton
    assert_equal Vector2D.e, Vector2D.e * 1
  end

  def test_2d_division
    assert_equal Vector2D.new(1, 1), Vector2D.new(2, 2) / 2
  end

  def test_dimension
    assert_equal 4, Vector.new(1, 2, 3, 4).dimension
  end

  def test_length
    assert_equal 30, Vector.new(1, 2, 3, 4).length
  end

  def test_normalize
    assert_equal Vector.new(0.25, 0.25, 0.25, 0.25),
                 Vector.new(1, 1, 1, 1).normalize
  end

  def test_equals
    assert_equal Vector.new(1, 1, 1, 1),
                 Vector.new(1, 1, 1, 1)
  end

  def test_get_by_index
    assert_equal 1, Vector.new(1, 2, 3, 4)[0]
  end

  # def test_set_by_index
  #   vector = Vector.new(1, 2, 3, 4)
  #   vector[0] = 5
  #
  #   assert_equal Vector.new(5, 2, 3, 4), vector
  # end

  def test_addition
    assert_equal Vector.new(5, 5, 5, 5),
                 Vector.new(1, 2, 3, 4) + Vector.new(4, 3, 2, 1)
  end

  def test_subtraction
    assert_equal Vector.new(0, 0, 0, 0),
                 Vector.new(1, 2, 3, 4) - Vector.new(1, 2, 3, 4)
  end

  def test_multiplication
    assert_equal Vector.new(2, 4, 6, 8),
                 Vector.new(1, 2, 3, 4) * 2
  end

  def test_division
    assert_equal Vector.new(1, 2, 3, 4),
                 Vector.new(2, 4, 6, 8) / 2
  end
end
