<?php
// Check for empty fields
if(empty($_POST['dname'])       ||
   empty($_POST['name'])        ||
   empty($_POST['email'])       ||
   empty($_POST['phone'])       ||
   empty($_POST['check'])       ||
   empty($_POST['message'])     ||
   !filter_var($_POST['email'],FILTER_VALIDATE_EMAIL))
   {
    echo "No arguments Provided!";
    return false;
   }

$dname = $_POST['dname'];
$name = $_POST['name'];
$email_address = $_POST['email'];
$phone = $_POST['phone'];
$message = $_POST['message'];
$checkbox = $_POST['check'];



if(isset($_POST['check'])) {
  print_r($_POST); //print all checked elements
}

// Create the email and send the message
$to = 'sakshama@buffalo.edu'; // Add your email address inbetween the '' replacing            
//yourname@yourdomain.com - This is where the form will send a message to.
$email_subject = "Website Contact Form:  $dname, $name";
$email_body = "You have received a new message from your website contact form.\n\n"."Here are the        
details:\n\nDName: $dname\n\nName: $name\n\nEmail: $email_address\n\nPhone: $phone\n\nMessage:\n$message\n\nCheckbox:\n$check";
$headers = "From: noreply@yourdomain.com\n"; // This is the email address the generated message will     
//be from. We recommend using something like noreply@yourdomain.com.
$headers .= "Reply-To: $email_address";	
mail($to,$email_subject,$email_body,$headers);
return true;      
?>
