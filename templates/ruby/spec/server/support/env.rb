# env.rb - support for locating class files based on class name 
# for Ruby reference server

def prepend_include_path(path)
  $LOAD_PATH.unshift(path)
end

def absolute_path
  File.dirname(File.expand_path(__FILE__))
  end

def prepend_relative_include_paths(*paths)
  prepend_include_path File.join(absolute_path, *paths)
end

# setup for Ruby Reference server and spec_wire's developer specs

prepend_relative_include_paths '..'
