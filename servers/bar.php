<?php
class Bar {
  var $val1;
  var $val2;
  function __construct($arg1, $arg2) {
    $this->val1 = $arg1;
    $this->val2 = $arg2;
  }
  
  function find($arg) { return array('1', '2'); }
  function locate() { return ''; }
}
?>