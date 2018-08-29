#!/usr/bin/perl -w

use strict;
use warnings;

use Date::Calc;
use DBI;

sub date_to_iso ($$$) { # ($year, $month, $day) -> YYYY-MM-DD
	return sprintf('%04d-%02d-%02d 00:00:00', @_);
}

my $path_prefix = "c:/Inetpub/wwwroot";
#my $path_prefix = "w:";
my $db_path = '/och/resources/databases/och.mdb';
my $dsn = "driver=Microsoft Access Driver (*.mdb); dbq=$path_prefix$db_path";
my $db = DBI->connect("dbi:ODBC:$dsn");

my ($y, $m, $d) = Date::Calc::Today();
($y, $m, $d) = Date::Calc::Add_Delta_YMD($y, $m, $d, 0, 0, -90);
my $date = date_to_iso($y, $m, $d);
$date =~ s/(.*) .*/$1/;

my $querystring = "update Listings set status = 'Inactive' where date_listed <= #$date#;";
print $querystring;
my $query = $db->prepare($querystring);
$query->execute();