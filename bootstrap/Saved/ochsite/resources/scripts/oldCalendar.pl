#!/usr/bin/perl -w

use strict;
use warnings;

BEGIN {push(@INC, "c:\\inetpub\\wwwroot\\resources\\scripts");}

use POSIX;
use CGI;                 my $cgi = new CGI;
use Date::Calc qw(:all);
use Class::Struct;
use Cache::FileCache;    my $cache = new Cache::FileCache();
use GData;

################################################################################
#################### Handle params ####################

print $cgi->header;

my $use_cached = $cgi->param('cache');
my $year = $cgi->param('year');
my $month = $cgi->param('month');
my ($this_year, $this_month, $this_date) = Today();

unless ($year and $year == floor($year)) {
	$year = $this_year;
}

unless ($month and $month == floor($month) and $month > 0 and $month < 13) {
	$month = $this_month;
}

my @sources = split(',', $cgi->param('events'));

################################################################################
#################### Data model & constants ####################

use constant {
	SUNDAY    => 1,
	MONDAY    => 2,
	TUESDAY   => 3,
	WEDNESDAY => 4,
	THURSDAY  => 5,
	FIRDAY    => 6,
	SATURDAY  => 7,
};

struct Day =>
{
	year => '$',
	month => '$',
	date => '$',
	day_of_week => '$',
	events => '@',
};

################################################################################
#################### Get and add events ####################

my ($all_events_ref, $used_ref) = GData::getGData(@sources, $year, $month);
my @all_events = @$all_events_ref;
my %used = %$used_ref;

################################################################################
#################### Build calendar structure ####################

my @days;
my $first_dow_of_month = Day_of_Week($year, $month, 1);

my $calendar_cache_key = "$year-$month";
my $cached_calendar = $cache->get($calendar_cache_key);

if (defined $cached_calendar) {
	@days = @$cached_calendar;
}
else {
	my ($y, $m, $d, $dow);
	($y, $m, $d) = Add_Delta_YMD($year, $month, 1, 0 , 0, -1 * $first_dow_of_month);
	$dow = SUNDAY;
	
	until ($m == ($month % 12) + 1 and $dow == SUNDAY)
	{
		my $day = Day->new(year => $y, month => $m, date => $d, day_of_week => $dow);
		push(@days, $day);
		
		($y, $m, $d) = Add_Delta_YMD($y, $m, $d, 0, 0, 1);
		$dow = ($dow % 7) + 1;
	}
	
	$cache->set($calendar_cache_key, \@days, "24 hours");
}

foreach my $source_events (@all_events) {
	foreach my $event (@$source_events) {
		foreach (@{$event->dates}) {
			push(@{$days[$_ + $first_dow_of_month - 1]->events}, $event);
		}
	}
}

################################################################################
#################### Spit it out all nice'n'pretty ####################

print <<EOS;
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/transitional.dtd"><html>
	<head>
		<meta http-equiv='Content-Type' content='text/html;charset=utf-8'>
		<title>Calendar</title>
		<link rel='stylesheet' href='/resources/stylesheets/reset.css' type='text/css'>
		<link rel='stylesheet' href='/resources/stylesheets/calendar.css' type='text/css'>
	<body>
	</head>
		<table class='calendar'>
			<thead>
				<tr>
					<th scope='col'>Sunday</th>
					<th scope='col'>Monday</th>
					<th scope='col'>Tuesday</th>
					<th scope='col'>Wednesday</th>
					<th scope='col'>Thursday</th>
					<th scope='col'>Friday</th>
					<th scope='col'>Saturday</th>
				</tr>
			</thead>
			<tbody>
EOS

foreach (@days)
{
	my @events = sort {$a->time <=> $b->time} @{$_->events};
	my $class = ($_->month != $month) ? 'other_month' : (($_->date == $this_date) ? 'today' : '');
	
	print "\t\t\t\t<tr>\n" if ($_->day_of_week == SUNDAY);
	print "\t\t\t\t\t<td class='$class'>\n";
	print "\t\t\t\t\t\t<span class='date'>" .  $_->date . "</span>\n";
	
	if ($events[0]) {
		print "\t\t\t\t\t\t<dl class='events'>\n";
		foreach (@events) {
			print "\t\t\t\t\t\t\t<dt class='" . $_->calendar . "'>" . $_->time . "</dt>\n";
			print "\t\t\t\t\t\t\t<dd class='" . $_->calendar . "'>";
			print (($_->url) ? "<a href='" . $_->url . "' target='_blank'>" . $_->name . "</a>" : $_->name);
			print "</dd>\n";
		}
		print "\t\t\t\t\t\t</dl>\n";
	}
	
	print "\t\t\t\t\t</td>\n";
	print "\t\t\t\t</tr>\n" if ($_->day_of_week == SATURDAY);
}

print "\n\t\t\t</tbody>\n\t\t</table>";
print "\n\t\t<div id='key'>\n\t\t\t<h4>Key:</h4>\n\t\t\t<ul>";

foreach (@sources) {
	print "\n\t\t\t\t<li class='$_'><a href='" . GData::sources->{$_}[2] . "' target='_blank'>" . GData::sources->{$_}[0] ."</a></li>" if ($used{$_});
}

print "\n\t\t\t</ul>\n\t\t</div>";
print "\n\t</body>\n</html>";


