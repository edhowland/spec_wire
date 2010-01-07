class Bar
  attr_accessor :val1, :val2
  attr_accessor :foo, :baz

  def initialize(v1, v2)
    @val1 = v1
    @val2 = v2
  end
  def baz?
    false
  end
  def to_json(*args)
    {
      :json_class => self.class.name,
      :data => [val1, val2],
      :id => object_id
    }.to_json(*args)
  end
  def self.find(count)
    count
  end
  def self.locate
    'y'
  end
end