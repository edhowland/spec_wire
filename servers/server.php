<?php
  // REST server for SpecWire in PHP
  require_once 'lib/limonade.php';
  require_once 'bar.php';

  dispatch('/', 'get_it');
      function get_it() {
        return 'GET Status 200 OK';
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
        $object = new $name();
        $results = array('json_class' => $name
          , 'data' => '[1,2]'
          ,  'id' => spl_object_hash($object));
        return json_encode($results);
      }
      
    dispatch_put('/object/:id/msg/:message', 'send_message');
      function send_message() {
        $id = params('id');
        $message = params('message');
        # TODO get from actual object stash
        $object = new Bar(1,2); # faked
        $result = $object->$message();
        return json_encode(array($result));
      }
      
  run();
    
?>