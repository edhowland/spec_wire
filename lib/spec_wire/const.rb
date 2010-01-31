class Module
  
  def class_cache
    SpecWire::Initializer.config.class_cache
  end
  
  def const_missing(name)
    fname=name.to_s.downcase
    class_path=File.join(class_cache, "#{fname}.rb")
    File.open(class_path, 'w+') do |f|
      f.puts <<-EOC
        class #{name} < ClassProxy; end
      EOC
    end unless File.exists?(class_path)
    require class_path
    klass = const_get(name)
    return klass if klass
    raise "Class not found: #{name}" # getting here something is really fubar'd    
  end
end