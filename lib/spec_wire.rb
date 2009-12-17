def array_upto_symbol(array, sym= :nil?)
  (array - Object.new.public_methods).reject {|e| e =~ /\=$/}
end

def object_to_hash(object, sym= :nil?)
  return array_upto_symbol(object.public_methods, sym).inject({:id => object.object_id, :meta => {:class_name => object.class.name}}) do |hash, method_name|
    hash[method_name] = object.send method_name
    hash
  end
end