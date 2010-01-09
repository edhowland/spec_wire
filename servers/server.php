<?php
  // REST server for SpecWire in PHP
  function __autoload($class_name) {
      $file = $class_name . '.php';
      if (file_exists($file)) {
        require_once $file;
      }
      else {
        throw new Exception("Class ($class_name) not found");
      }
  }
  require_once 'lib/limonade.php';

  // use of ErrorException within custom error handler
  // not built in to later versions of PHP??/
  function exception_error_handler($errno, $errstr, $errfile, $errline ) {
    logit("(possible) error handled:" . $errstr . "($errno)" . " in => $errfile($errline)");
    if ($errno < 512) {
      throw new ErrorException($errstr, 0, $errno, $errfile, $errline);
    }
  }
  set_error_handler("exception_error_handler");
  
  function not_found($errno, $errstr, $errfile, $errline) {
    $errmsg = "error occured($errno): $errstr in=>$errfile:$errline"; 
    logit('not found ' . $errmsg);
    return json_encode(array("error" => $errmsg));
  }
  
  function server_error($errno, $errstr, $errfile, $errline) {
    $errmsg = "error occured($errno): $errstr in=>$errfile:$errline"; 
    logit("srver error:" . $errmsg);
    return json_encode(array("error" => $errmsg));
  }

  error(E_LIM_HTTP, 'my_http_errors');
  function my_http_errors($errno, $errstr, $errfile, $errline)
  {
    $errmsg = "error occured($errno): $errstr in=>$errfile:$errline"; 
    logit("http error:" . $errmsg);
    status($errno);
    return json_encode(array("error" => $errmsg));
  }

  error(E_LIM_PHP, 'my_php_errors');
  function my_php_errors($errno, $errstr, $errfile, $errline)
  {
    $errmsg = "error occured($errno): $errstr in=>$errfile:$errline"; 
    logit("php error:" . $errmsg);
    status(422);
    return json_encode(array("error" => $errmsg));
  }
  
  

  function store_object_with_id($object, $id) {
    $_SESSION[$id] = $object;
  }
  
  function store_object($object) {
    store_object_with_id($object, spl_object_hash($object));
  }
  
  function get_object($id) {
    return $_SESSION[$id];
  }
  
  function isAssoc($arr)
  {
    return array_keys($arr) !== range(0, count($arr) - 1);
  }
  
  function convert_obj($obj) {
    if (is_string($obj)) {
      return var_export($obj, true);
    }
    elseif (is_array($obj) || isAssoc($obj)) {
      return var_export($obj, true);
    }
    else {
      return $obj;
    }
  }
  
  function convert_objs($arr) {
    return array_map('convert_obj', $arr);
  }
  
  function dump_arg($arg) {
    return var_export($arg, true);
  }
  
  function logit() {
    $args = func_get_args();
    $msg = array_shift($args);
    
    $args = array_map('dump_arg', $args);
    
    $fh = fopen("/tmp/limonade.log", "a+");
    fwrite($fh, $msg . '|' . implode(',', $args) .  "|\n");
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
        halt(NOT_FOUND, json_encode(array("error" => 'Object<' .params('id') . '> not found')));
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
      try {
        $name = params('name');
        $message = params('message');
        $args = params('args');
      
        $object = new $name();
        $result = $object->$message();
        return json_encode(array($result));
      }
      catch (Exception $e) {
        logit('Exception ' . $e->getMessage());
        halt(422, json_encode(array("error" => "Error processing request :" . $e->getMessage())));
        return json_encode(array('error' => $e->getMessage()));
      }
    }
      
   dispatch_post('/class/:name', 'new_object');
      function new_object() {
        try {
          $name = params('name');
          $args = $_POST['args'];
          $argstr = $args;
          logit('POST: args ', $args);
          if (is_null($args) || $args == '[]') {
            $object = new $name();
          }
          else {
            logit('args b4 decode', $args);
            $args = json_decode($args, true);
            logit('args after decode', $args);
            if (is_array($args)) {
              $args = convert_objs($args);
              logit("args after conversion", $args);
              $argstr = join($args, ",");
              logit("argstr after join", $argstr);
            }
            else {
              $argstr = $args;
            }
            logit("calling " . "return new $name($argstr);");
            $object = eval("return new $name($argstr);");
          }
          store_object($object);
          $results = array('json_class' => $name
            , 'data' => $argstr
            ,  'id' => spl_object_hash($object));
          
          return json_encode($results);
        }
        catch(Exception $e) {
          logit('Exception ' . $e->getMessage());
          halt(422, json_encode(array("error" => $e->getMessage())));
          return json_encode(array('error' => $e->getMessage()));
          }
      }
      
    dispatch_put('/object/:id/msg/:message', 'send_message');
      function send_message() {
        // set_error_handler("error_handler");
        try {
          $message = params('message');
          $n_message = $message;
          $id = params('id');
          $object = get_object($id);
          if (is_null($object)) {
            logit('object not found', params('id'));
            halt(NOT_FOUND, json_encode(array("error" => 'Object not found')));
            return "object:" . params('id') . ": was not found";
          }
          else {
            $args = $_POST['args'];
            logit('message :' . $message . ' aegs |' . $args . '|');
            if (is_null($args) || $args == '[]') {
              logit('args are empty');
              $result = $object->$message;
              logit("\$object->$message returning ", $result);
            }
            else {
              logit('decoding args|' . $args . '|');
              $args = json_decode($args);
              logit('args are :', $args);
              if (preg_match('/\=$/', $message) == 1) {
                $n_message = substr($message, 0, strlen($message) - 1);
                logit("\$object->$n_message = ", $args[0]);
                if (!property_exists($object, $n_message)) {
                  throw new Exception("property $n_message (original message:$message) does not exist");
                }
                $object->$n_message = $args[0];
                $result = array();
              } else {
                logit("\$obect->$message()"); 
                if (!method_exists($object, $message)) {
                  throw new Exception("method $message does not exist");
                }
                $result = $object->$message($args);
                logit("returning ", $result);
              }
            }
            store_object_with_id($object, $id);
            return json_encode(array($result));
          }
        }
        catch (Exception $e) {
          logit('Exception occured :' . $e->getMessage());
          halt(422, json_encode(array("error" => $e->getMessage())));
          return json_encode(array('error' => $e->getMessage()));
        }
      }
      
  run();
    
?>