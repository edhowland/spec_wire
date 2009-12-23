<?php
  // REST server for SpecWire in PHP
  function __autoload($class_name) {
      require_once $class_name . '.php';
  }
  require_once 'lib/limonade.php';

  function not_found($errno, $errstr, $errfile=null, $errline=null){
    return $errstr;
  }
  
  function store_object($object) {
    $_SESSION[spl_object_hash($object)] = $object;
  }
  
  function get_object($id) {
    return $_SESSION[$id];
  }
  
  function logit($msg) {
    $fh = fopen("/tmp/limonade.log", "a+");
    fwrite($fh, $msg . "\n");
    fclose($fh);
  }


  dispatch('/', 'get_it');
      function get_it() {
        return 'GET Status 200 OK';
      }

  dispatch('/object/:id', 'raw_get_object');
    function raw_get_object() {
      $object = get_object(params('id'));
      if (is_null($object)) {
        halt(NOT_FOUND, 'Object<' .params('id') . '> not found');
        return "object:" . params('id') . ": was not found";
      }
      // TODO: investigate why spl_object_hash does not eql variable in $_SESSION
      else {
        $results = array('json_class' => get_class($object)
          , 'data' => array(1,2)
          ,  'id' => params(id)); // spl_object_hash($object));
        return json_encode($results);
      }
    }
      
   dispatch('/class/:name/msg/:message/args/:args', 'send_class_message');
    function send_class_message() {
      $name = params('name');
      $message = params('message');
      $args = params('args');
      
      $object = new $name();
      $result = $object->$message();
      return json_encode(array($result));
    }
      
   dispatch_post('/class/:name', 'new_object');
      function new_object() {
        $name = params('name');
        $args = $_POST['args'];
        logit('POST: args ' .$args);
        if (is_null($args) || $args == '[]') {
          $object = new $name();
        }
        else {
          $args = json_decode($args);
          if (is_array($args)) {
            $argstr = join($args, ",");
          }
          else {
            $argstr = $args;
          }
          $object = eval("return new $name($argstr);");
        }
        store_object($object);
        $results = array('json_class' => $name
          , 'data' => $args
          ,  'id' => spl_object_hash($object));
          
        return json_encode($results);
      }
      
    dispatch_put('/object/:id/msg/:message', 'send_message');
      function send_message() {
        $message = params('message');
        $object = get_object(params('id'));
        if (is_null($object)) {
          halt(NOT_FOUND, 'Object<' .params('id') . '> not found');
          return "object:" . params('id') . ": was not found";
        }
        else {
          $args = $_POST['args'];
          if (is_null($args) || $args == '[]') {
            $result = $object->$message();
          }
          else {
            $args = json_decode($args);
            $result = $object->$message($args);
          }
          return json_encode(array($result));
        }
      }
      
  run();
    
?>