package Event;

use strict;
use warnings;

use Class::Struct;
use DBI;

struct Event => {
	id => '$',
	title => '$',
	division => '$',
	event_type => '$',
	description => '$',
	is_all_day => '$',
	time_start => '$',
	time_end => '$',
	is_repeated => '$',
	date_start => '$',
	date_end => '$',
	days_of_week => '$',
};

my $path_prefix = "c:/Inetpub/wwwroot";
# my $path_prefix = "w:";
my $db_path = '/resources/databases/calendar.mdb';
my $dsn = "driver=Microsoft Access Driver (*.mdb); dbq=$path_prefix$db_path";
my $db = DBI->connect("dbi:ODBC:$dsn");


sub date_to_iso ($$$) { # ($year, $month, $day) -> YYYY-MM-DD
	return sprintf('%04d-%02d-%02d 00:00:00', @_);
}

sub date_from_iso ($) { # YYYY-MM-DD -> ($year, $month, $day)
	return split(/-/, shift);
}

sub time_to_12hr ($) {
	my ($h, $m) = split(/:/, shift);
	return sprintf('%d:%02d %s', (($h - 1) % 12) + 1, $m, ($h < 12) ? "am" : "pm");
}

# Takes a start and end date in ISO 8601 (YYYY-MM-DD)
# Outputs array ref sorted ascending by date
sub in_date_range {
	my ($start_date, $end_date) = @_;
	
	my $query = <<EOF

select id, title, division, description, is_all_day, time_start, time_end, is_repeated, date_start, date_end, days_of_week
from Events
where
	date_end >= ? and
	date_start <= ?
order by date_start asc;

EOF
;
	my $events = $db->prepare($query);
	$events->execute($start_date, $end_date);
	
	my @events;
	while (my $event = $events->fetchrow_hashref()) {
		push(@events, Event->new(%$event));
	}
	
	return \@events;
}

struct Division => {
	id => '$',
	name => '$',
	home_page => '$',
	color => '$',
	background_color => '$',
	abbreviation => '$',
};

# fetches the categories from the database
sub divisions {
	my $divisions = $db->prepare('select * from Divisions');
	$divisions->execute or die("Failed to query database");
	
	my @divisions;
	while (my $division = $divisions->fetchrow_hashref()) {
		push(@divisions, Division->new(%$division));
	}
	
	return \@divisions;
}

1;