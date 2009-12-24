<?php
class Bar {
  var $val1;
  var $val2;
  function __construct($arg1, $arg2) {
    $this->val1 = $arg1;
    $this->val2 = $arg2;
  }
  // function val1() { return $this->val1; }
  // function val2() { return $this->val2; }
  
  function __get($name) {
    switch($name) {
      case 'val1':
        return $this->val1;
        break;
      case 'val2':
        return $this->val2;
        brak;
      default:
        return 0;
    }
  }
  
  function __set($name, $value) {
    switch($name) {
      case 'val1':
        $this->val1 = $value;
        break;
      case 'val2':
        $this->val2 = $value;
        brak;
      default:
        return 0;
    }    
  }
  
  function find($arg) { return array('1', '2'); }
  function locate() { return ''; }
}
?>