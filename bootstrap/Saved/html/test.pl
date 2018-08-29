#!c:perlbinperl.exe

use strict;
use CGI;
my $test = new CGI;

print $test->header(“text/html”),$test->start_html(“Perl Test”);
print $test->h1(“Perl is working!”);
print $test->end_html;