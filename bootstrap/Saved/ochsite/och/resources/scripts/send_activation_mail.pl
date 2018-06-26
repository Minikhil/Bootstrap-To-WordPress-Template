#!/usr/bin/perl -w

use strict;
use warnings;

use CGI;
use DBI;
use Data::Dumper;
use Net::SMTP;

my $cgi = new CGI;
my $id = $cgi->param('id');
my $listing_url = "/och/admin/listing.asp?id=$id";

my $path_prefix = "E:/Inetpub/wwwroot/subboard.com";
my $DSN = "driver=Microsoft Access Driver (*.mdb); dbq=$path_prefix/och/resources/databases/och.mdb";
my $db = DBI->connect("dbi:ODBC:$DSN");

my $listings = $db->prepare("select street_number, street, email from Listings where id = ?;");
$listings->execute($id);
my ($street_number, $street, $email) = $listings->fetchrow_array();

my $body;

if ($cgi->request_method eq 'POST') {
	my $message = "To: $email\nSubject: Listing activated\nYour listing at $street_number $street has been activated and can be viewed at http://subboard.com/och/listing.asp?id=$id. To learn more about our policies and the importance of a Certificate of Occupancy please visit our website at: http://subboard.com/och/terms.asp";
	my $mailer = new Net::SMTP('smtp.buffalo.edu');
	
	$mailer->mail('sbi-och@buffalo.edu');
	$mailer->to($email);
	$mailer->data;
	$mailer->datasend($message);
	$mailer->dataend;
	$mailer->quit;
	
	$body = "<p>Email sent to $email.</p>";
} else {
	$body = <<EOS
<p>Send activation email to $email?</p>
<form method='POST' action='/och/resources/scripts/send_activation_mail.pl'>
	<div>
		<input type='hidden' name='id' id='id' value='$id'>
		<input type='submit' name='submit' id='submit' value='Send'>
	</div>
</form>
EOS
	;
}


print $cgi->header();

print <<EOS
<html>
	<head>
		<title>Send activation email</title>
	</head>
	<body>
		$body
		<p><a href='$listing_url'>Back to listing</a></p>
	</body>
</html>
EOS
;