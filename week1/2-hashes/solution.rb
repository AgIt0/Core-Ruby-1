class Hash
  def pick(*keys)
    select { |key| keys.include? key }
  end

  def except(*keys)
    reject { |key| keys.include? key }
  end

  def compact_values
    reject { |_, elem| elem.nil? }
  end

  def defaults(other_hash)
    other_hash.merge(self)
  end

  def values_map(&block)
    Hash[keys.zip(values.map(&block))]
  end

  def pick!(*keys)
    select! { |key| keys.include? key }
    self
  end

  def except!(*keys)
    reject! { |key| keys.include? key }
    self
  end

  def compact_values!
    reject! { |_, elem| elem.nil? }
    self
  end

  def defaults!(other_hash)
    merge!(other_hash) { |_, old_val, _| old_val }
  end
end

class Symbol
  def to_proc_mine
    proc { |obj, *args| obj.send(self, *args) }
  end
end
