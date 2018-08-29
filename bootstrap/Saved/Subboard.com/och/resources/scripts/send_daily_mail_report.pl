#!/usr/bin/perl -w

use strict;
use warnings;
use lib '/home/tesmith3/perl/lib/perl5/site_perl/5.10/i686-cygwin/';

use DBI;
use Net::SMTP;

my $path_prefix = 'w:'; # "E:/Inetpub/wwwroot/subboard.com/och/"
my $DSN = "driver=Microsoft Access Driver (*.mdb); dbq=$path_prefix/och/resources/databases/och.mdb";
my $db = DBI->connect("dbi:ODBC:$DSN");

my (undef, undef, undef, $d, $m, $y, undef, undef, undef) = localtime();
my $date = ($m + 1) . "/$d/" . ($y + 1900);

my $listings = $db->prepare("select id, street_number, street, locality, postal_code, total_bedrooms, available_bedrooms, rent, security_deposit from Listings where status = 'Active' and date_listed = #$date#");
$listings->execute();

my $message = "To: \"SBI Off-Campus Housing mailing list\"\nSubject: Today's Listings\n";
$message .= "The following listings have been added to the database today, $date:\n";

my @listing;
while (@listing = $listings->fetchrow_array()) {
	my ($id, $street_number, $street, $locality, $postal_code, $total_bedrooms, $available_bedrooms, $rent, $security_deposit) = @listing;
	($rent, $security_deposit) = (int($rent), int($security_deposit));
	my $state = ($locality eq 'Canada' ? 'Ontario' : 'NY');
	
	my $listing_text = "\n$street_number $street\n$locality, $state $postal_code\n$total_bedrooms bedrooms, $available_bedrooms available\n\$$rent/mo, \$$security_deposit deposit\nhttp://subboard.com/och/listing.asp?id=$id\n";
	$message .= $listing_text;
}

print $message;

my $mailer = new Net::SMTP('smtp.buffalo.edu');

$mailer->mail('sbi-och@buffalo.edu');
$mailer->to('sbi-off-campus-housing-list@listserv.buffalo.edu');
$mailer->data;
$mailer->datasend($message);
$mailer->dataend;
$mailer->quit;