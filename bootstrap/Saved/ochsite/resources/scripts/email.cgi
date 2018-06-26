use CGI;

$cgi = new CGI;

print $cgi->param('a');
print $cgi->param('b');

print $cgi->header;

print "Foo!";