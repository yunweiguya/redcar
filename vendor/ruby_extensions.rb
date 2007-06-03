
class PickyHash < Hash
  def [](id)
    r = super(id)
    unless r
      raise ArgumentError, "no hash pair with key: #{id.inspect}"
    end
    r
  end
end

class Hash
  def picky
    ph = PickyHash.new
    self.each do |k, v|
      ph[k] = v
    end
    ph
  end
end

class NilClass
  def copy
    nil
  end
end

class String
  def delete_slice(range)
    unless range.begin <= range.end
      raise ArgumentError, "String#delete_slice expects an *ordered* range."
    end
    unless range.begin >= 0 and range.end >= 0
      raise ArgumentError, "String#delete_slice expects only positive range endpoints."
    end
    s = range.begin
    e = range.end
    first = self[0..(s-1)]
    second = self[(e+1)..-1]
    if s == 0
      first = ""
    end
    if e >= self.length-1
      second = ""
    end
    self.replace(first+second)
    self
  end
end

if $0 == __FILE__
  p "01234".delete_slice(1..2) == "034"
  p "01234".delete_slice(0..1) == "234"
  p "01234".delete_slice(0..0) == "1234"
  p "01234".delete_slice(0..4) == ""
  p "01234".delete_slice(4..4) == "0123"
end
