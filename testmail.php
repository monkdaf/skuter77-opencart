<?php
ini_set( 'display_errors', 1 );
error_reporting( E_ALL );
$from = "info@skuter77.ru";
$to = "monkdaf@gmail.com";
$subject = "PHP Mail Test";
$message = "Test";
$headers = "From:" . $from;
mail($to,$subject,$message, $headers);
echo "email sent";
?>
