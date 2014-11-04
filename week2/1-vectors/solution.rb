class Vector2D
  attr_accessor :x, :y

  # The unit vector (1, 0).
  def self.e
    Vector2D.new(1, 0)
  end

  # The unit vector (0, 1).
  def self.j
    Vector2D.new(0, 1)
  end

  def initialize(x, y)
    @x = x
    @y = y
  end

  def length
    Math.sqrt(@x * @x + @y * @y)
  end

  def normalize
    length = self.length

    if length == 0 || length == 1
      Vector2D.new(@x, @y)
    else
      Vector2D.new(@x / length, @y / length)
    end
  end

  def ==(vector_or_scalar)
    if vector_or_scalar.instance_of?(Vector2D)
      @x == vector_or_scalar.x && @y == vector_or_scalar.y
    else
      @x == vector_or_scalar && @y == vector_or_scalar
    end
  end

  def +(vector_or_scalar)
    vector_for_operation(:+, vector_or_scalar)
  end

  def -(vector_or_scalar)
    vector_for_operation(:-, vector_or_scalar)
  end

  def *(scalar)
    vector_for_operation(:*, scalar)
  end

  def /(scalar)
    vector_for_operation(:/, scalar)
  end

  def to_s
    "#{@x}:#{@y}"
  end

  def inspect
    "#<Vector2D:#{object_id} @x=#{@x}, @y=#{@y}>"
  end

  alias_method :magnitude, :length

  private

  def vector_for_operation(operation, vector_or_scalar)
    if vector_or_scalar.instance_of?(Vector2D)
      Vector2D.new(operation.to_proc.call(@x, vector_or_scalar.x),
                   operation.to_proc.call(@y, vector_or_scalar.y))
    else
      Vector2D.new(operation.to_proc.call(@x, vector_or_scalar),
                   operation.to_proc.call(@y, vector_or_scalar))
    end
  end
end

class Vector
  def initialize(*components)
    # Let's make it more interesting here. I wanna initialize the vector with
    # `Vector.new(1, 2, 3, 4)` and `Vector.new([1, 2, 3, 4])` and expect the
    # same vector.
    @components = components.flatten
  end

  def dimension
    @components.length
  end

  def length
    @components.map { |x| x * x }
      .reduce(0){ |sum, n| sum + n }
  end

  def normalize
    lenght = self.length
    if length == 0 || length == 1
      Vector.new(@components)
    else
      Vector.new(@components.map { |x| x / length.to_f })
    end
  end

  def [](index)
    @components[index]
  end

  def []=(index, value)
    @components[index] = value
  end

  def ==(vector_or_scalar)
    if vector_or_scalar.instance_of?(Vector)
      @components.sort == vector_or_scalar.components
    else
      @components.all? { |x| x == vector_or_scalar }
    end
  end

  def +(vector_of_same_dimension_or_scalar)
    vector_for_operation(:+, vector_of_same_dimension_or_scalar)
  end

  def -(vector_of_same_dimension_or_scalar)
    vector_for_operation(:-, vector_of_same_dimension_or_scalar)
  end

  def *(scalar)
    vector_for_operation(:*, scalar)
  end

  def /(scalar)
    vector_for_operation(:/, scalar)
  end

  def to_s
    @components.to_s
  end

  def inspect
    "#<Vector:#{object_id} @components=#{@compnents}>"
  end

  alias magnitude length

  protected

  attr_accessor :components

  private

  def vector_for_operation(operation, vector_or_scalar)
    if vector_or_scalar.instance_of?(Vector)
      components = @components.each_with_index.map do |component, i|
        operation.to_proc.call(component, vector_or_scalar[i])
      end
    else
      components = @components.map do |component|
        operation.to_proc.call(component, vector_or_scalar)
      end
    end
    Vector.new(components)
  end
end
