# env.rb - support for locating class files based on class name
# follows Rails convention of file_with_underscores <=> FileWithUnderscores
# for Ruby reference server

class String
  def to_camelcase
   self.sub(/^([a-z])/) {|s| $1.upcase}.gsub(/_([a-z])/) {|s| $1.capitalize} 
  end
  def to_underscores
    self.sub(/^([A-Z])/) {|s| $1.downcase}.gsub(/([A-Z])/) {|s| '_' + $1.downcase}
  end
end

def prepend_include_path(path)
  $LOAD_PATH.unshift(path)
end

def absolute_path
  File.dirname(File.expand_path(__FILE__))
  end

def prepend_relative_include_paths(*paths)
  prepend_include_path File.join(absolute_path, *paths)
end

def load_class_file(class_name)
  require class_name.to_underscores
end

# setup for Ruby Reference server and spec_wire's developer specs
prepend_relative_include_paths '..'
