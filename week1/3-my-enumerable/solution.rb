module MyEnumerable
  def map
    [].tap do |arr|
      each { |x| arr << yield(x) }
    end
  end

  def filter
    [].tap do |arr|
      each { |x| arr << x if yield(x) }
    end
  end

  def reject
    [].tap do |arr|
      each { |x| arr << x unless yield(x) }
    end
  end

  def reduce(initial = nil)
    acc = initial
    each do |a|
      if acc.nil?
        acc = a
      else
        acc = yield(acc, a)
      end
    end
    acc
  end

  def any?
    if block_given?
      each do |x|
        return true if yield(x)
      end
    else
      each do |x|
        return true if x
      end
    end
    false
  end

  def all?
    if block_given?
      each do |x|
        return false unless yield(x)
      end
    else
      each do |x|
        return false unless x
      end
    end
    true
  end

  def each_cons(n)
    [].tap do |array|
      each_with_index do |_, index|
        array << @data[index, n] if @data[index, n].size == n
      end
    end
  end

  def include?(element)
    each do |x|
      return true if x == element
    end
    false
  end

  def count(element = nil)
    sum = 0
    each do |x|
      sum += 1 if element == x
    end
    sum
  end

  def size
    reduce(0) { |sum| sum + 1 }
  end

  def group_by
    {}.tap do |hash|
      each do |element|
        if hash[yield(element)]
          hash[yield(element)] << element
        else
          hash[yield(element)] = [element]
        end
      end
    end
  end

  def min
    min = @data[0]

    each do |element|
      comp = if block_given?
               yield(element, min)
             else
               element <=> min
             end

      min = element if comp < 0
    end

    min
  end

  def min_by
    min = @data[0]

    each do |element|
      comp = yield(element) <=> yield(min)
      min = element if comp < 0
    end

    min
  end

  def max
    max = @data[0]

    each do |element|
      comp = if block_given?
               yield(element, max)
             else
               element <=> max
             end

      max = element if comp > 0
    end

    max
  end

  def max_by
    max = @data[0]

    each do |element|
      comp = yield(element) <=> yield(max)
      max = element if comp > 0
    end

    max
  end

  def minmax(&block)
    [min(&block), max(&block)]
  end

  def minmax_by(&block)
    [min_by(&block), max_by(&block)]
  end

  def take(n)
    @data[0, n]
    [].tap do |array|
      each_with_index { |x, index| array << x if index < n }
    end
  end

  def take_while
    [].tap do |array|
      each do |element|
        if yield(element)
          array << element
        else
          return array
        end
      end
    end
  end

  def drop(n)
    n.times { @data.shift }
    @data
  end

  def drop_while
    dropping = true
    [].tap do |array|
      each do |element|
        array << element unless dropping &&= yield(element)
      end
    end
  end
end
