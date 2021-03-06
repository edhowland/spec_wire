<?php
  // env.php - setups for include paths and other site specific
  // stuff like include file names for functions not autoloaded via class name
  
  class LoadError extends Exception {}
  
  function prepend_include_path($path) {
    ini_set('include_path', $path . PATH_SEPARATOR .ini_get('include_path'));
  }
  
  function file_included_in_path($filename) {
    $include_path = ini_get('include_path');
    $paths = explode(PATH_SEPARATOR, $include_path);
    $exists = false;
    foreach($paths as $path) {
      if (file_exists($path . '/' . $filename)) {
        $exists = true;
        break;
      }
    }
    return $exists;
  }
    /**
   * Translates a camel case string into a string with underscores (e.g. firstName -&gt; first_name)
   * @param    string   $str    String in camel case format
   * @return    string            $str Translated into underscore format
   */
  function from_camel_case($str) {
    $str[0] = strtolower($str[0]);
    $func = create_function('$c', 'return "_" . strtolower($c[1]);');
    return preg_replace_callback('/([A-Z])/', $func, $str);
  }

  /**
   * Translates a string with underscores into camel case (e.g. first_name -&gt; firstName)
   * @param    string   $str                     String in underscore format
   * @param    bool     $capitalise_first_char   If true, capitalise the first char in $str
   * @return   string                              $str translated into camel caps
   */
  function to_camel_case($str, $capitalise_first_char = true) {
    if($capitalise_first_char) {
      $str[0] = strtoupper($str[0]);
    }
    $func = create_function('$c', 'return strtoupper($c[1]);');
    return preg_replace_callback('/_([a-z])/', $func, $str);
  }
  
  # class map prefers these file names over the default
  # CamelCase(camel_case) versions
  # below is an example
  $class_map = array(
    "DashboardUsersSearchController" => "search.php"
  );
  
  function __autoload($class) {
    global $class_map;
    $file = $class_map[$class];
    if (is_null($file)) {
      $file = from_camel_case($class) . '.php';
    }
    if (file_included_in_path($file)) {
      require_once $file;
    }
    else {
      throw new LoadError("Class ($class) not found");
    }
  }
  
  
  
  // site specific include path
  prepend_include_path('../..');

?>