<?php
  // servers/server.php - REST/JSON server for spec_wire object message passing
  // protocol. Based on servers/server.rb

require_once 'lib/limonade.php';
           
        
        dispatch('/', 'my_get_function');
        # same as dispatch_get('my_get_function');
            function my_get_function()
            {
                return "GET Status 200 OK";
            }
        dispatch('/', 'hello');
               function hello()
               {
                   return 'Hello world!';
               }

        dispatch_post('/', 'my_post_function'); 
            function my_post_function()
            {
                // Create something
            }

        dispatch_update('/', 'my_update_function'); 
            function my_update_function()
            {
                // Update something
            }

        dispatch_delete('/', 'my_delete_function'); 
            function my_delete_function()
            {
                // Delete something
            }    
        
    run();
    
?>
