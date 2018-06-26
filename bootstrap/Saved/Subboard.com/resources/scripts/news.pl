#!/usr/bin/perl -w

use strict;
use warnings;

use CGI; my $cgi = new CGI;
use Date::Calc qw(:all);

BEGIN {push(@INC, "c:\\inetpub\\wwwroot\\resources\\scripts");}
use Builder;
use GData;

################################################################################
#################### Handle params ####################

print $cgi->header;

my $use_cached = $cgi->param('cache');
my $year = $cgi->param('year');
my $month = $cgi->param('month');
my ($this_year, $this_month, $this_date) = Today();
my $events = $cgi->param('events');

unless ($year) {
	$year = $this_year;
}

unless ($month) {
	$month = $this_month;
}

my $first_dow_of_month = Day_of_Week($year, $month, 1);
my $days_in_month = Days_in_Month($year, $month);

my @sources = split(',', $events); @sources = qw(sbi he wrub legal);

################################################################################
#################### Get days/events ####################


my @start = ($year, $month, 1);
my @end = Add_Delta_YMD($year, $month, 1, 0, 1, 0);
my ($days_ref, undef) = GData::getDaysWithEvents(@sources, @start, @end);

################################################################################
#################### Output ####################

use Builder; my $h = new Builder();

print
$h->div({'id' => 'news'}, sub {
	foreach my $day (@$days_ref) {
		$h->div('class' => 'days', sub {
			$h->h3({'class' => 'date'}, sprintf('%s, %s %u', Day_of_Week_to_Text($day->day_of_week), Month_to_Text($day->month), $day->date));
			$h->ul({'class' => 'events'}, sub {
				foreach my $event (@{$day->events}) {
					$h->li({'class' => 'events', 'id' => 'event-' . $event->id}, sub {
						$h->h4({'class' => 'name'}, GData::sources()->{$event->calendar}[0] . ' &ndash; ' . $event->name);
						$h->p({'class' => 'description'}, $event->url);
					});
				}
			});
		}) if $day->events->[0];
	}
});