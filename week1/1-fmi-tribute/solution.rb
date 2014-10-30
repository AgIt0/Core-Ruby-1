class Array
  def to_hash
    fail ArgumentError if flatten.count.odd?
    # reduce({}) { |hash, element| hash[element[0]] = element[1]; hash }
    each_with_object({}) { |element, hash| hash[element[0]] = element[1] }
  end

  def index_by(&block)
    Hash[map(&block).zip(self)]
  end

  def occurences_count
    Hash.new(0).tap do |hash|
      self.each { |element| hash[element] += 1 }
    end
  end

  def subarray_count(subarray)
    each_cons(subarray.length).count(subarray)
  end
end
