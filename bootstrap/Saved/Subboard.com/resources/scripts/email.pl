#!/usr/bin/perl

use CGI;

$cgi = new CGI;

$name = $cgi->param('a');
$domain = $cgi->param('b');

print $cgi->redirect("mailto:$name@$domain");