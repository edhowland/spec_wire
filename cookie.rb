response2 = RestClient.post(
    'http://localhost:3000/',
    {:param1 => "foo"},
    {:cookies => {:session_id => "1234"}}
  )
