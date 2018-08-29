#!/usr/bin/perl -w

use strict;
use warnings;

BEGIN {push(@INC, "E:\inetpub\wwwroot\resources\scripts");}
BEGIN {push(@INC, "E:\inetpub\wwwroot\resources\scripts\calendar");}
BEGIN {push(@INC, "w:\\resources\\scripts\\calendar");}

use CGI;
use Data::Dumper;
use Builder;
use LWP;
use JSON::XS;

my $cgi = new CGI;
print $cgi->header;

my $ua = new LWP::UserAgent;
my $response = $ua->get('http://twitter.com/statuses/user_timeline/jlm25.json');
my $data = JSON::XS::decode_json($response->content);

my $h = new Builder;

sub format_date ($) {
	my $date = shift;
	$date =~ m/(.*) .* .* (\d\d):(\d\d)/;
	
	my ($dow, $h, $m, $ap) = ($1, ($2 + 6) % 12 + 1, $3, ($2 > 16) ? "PM" : "AM");
	return "$dow $h:$m $ap";
}

sub linkify ($) {
	my $text = shift;
	$text =~ s/(http:\/\/.*?)(\s|$)/<a href='$1'>$1<\/a>/g;
	return $text;
}

print do {
	$h->div({'class' => 'widget'}, sub {
		$h->dl(sub {
			foreach (@$data) {
				$h->dt(format_date($_->{created_at}));
				$h->dd(linkify($_->{text}));
			}
		});
	});
};