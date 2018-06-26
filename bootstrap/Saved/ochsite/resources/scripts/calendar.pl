#!/usr/bin/perl -w

use strict;
use warnings;

BEGIN {push(@INC, "c:\\inetpub\\wwwroot\\resources\\scripts");}

use POSIX;
use CGI;                 my $cgi = new CGI;
use Date::Calc qw(:all);
use Cache::FileCache;    my $cache = new Cache::FileCache();
use GData;

use Data::Dumper;

################################################################################
#################### Handle params ####################

print $cgi->header;

my $use_cached = $cgi->param('cache');
my $year = $cgi->param('year');
my $month = $cgi->param('month');

my ($this_year, $this_month, $this_date) = Today();

my $events = $cgi->param('events');

unless ($year and $year == floor($year)) {
	$year = $this_year;
}

unless ($month and $month == floor($month) and $month > 0 and $month < 13) {
	$month = $this_month;
}

my $first_dow_of_month = Day_of_Week($year, $month, 1);
my $days_in_month = Days_in_Month($year, $month);

my ($prev_year, $prev_month) = Add_Delta_YM($year, $month, 1, 0, -1);
my ($next_year, $next_month) = Add_Delta_YM($year, $month, 1, 0, 1);

my @sources = split(',', $events);

################################################################################
#################### Data model & constants ####################

use constant {
	SUNDAY    => 1,
	MONDAY    => 2,
	TUESDAY   => 3,
	WEDNESDAY => 4,
	THURSDAY  => 5,
	FRIDAY    => 6,
	SATURDAY  => 7,
};

################################################################################
#################### Get days/events ####################

my @start = ($year, $month, 1);
my @end = ($next_year, $next_month, 1);

my ($days_ref, $used_ref) = GData::getDaysWithEvents(@sources, @start, @end);
my @days = @$days_ref;
my %used = %$used_ref;

################################################################################
#################### Build calendar structure ####################

my @calendar;
do {
	my ($y, $m, $d) = Add_Delta_YMD($year, $month, 1, 0, 0, 0 - $first_dow_of_month);
	
	while (($m % 12) <= ($month % 12) or ($month == 12 and $m != 1)) {
		my @week;
		for (my $dow = SUNDAY; $dow <= SATURDAY; $dow++) {
			push(@week, ($m == $month) ? $days[$d-1] : Day->new(year => $y, month => $m, date => $d, day_of_week => $dow));
			($y, $m, $d) = Add_Delta_YMD($y, $m, $d, 0, 0, 1);
		}
		push(@calendar, \@week);
	}
};

use Builder; my $h = new Builder();

print do {
	$h->div({'id' => 'key'}, sub {
		$h->ul(sub {
			foreach my $source (@sources) {
				$h->li({'class' => $source}, sub {
					$h->a({'href' => GData::sources->{$source}[2], 'target' => '_blank'}, GData::sources->{$source}[0]);
				}) if ($used{$source});
			}
		});
	});
	$h->div({'class' => 'calendar_controls'}, sub {
		$h->a({'href' => "calendar.asp?year=$prev_year&amp;month=$prev_month", 'class' => 'prev'}, 'Previous Month');
		$h->a({'href' => "calendar.asp?year=$next_year&amp;month=$next_month", 'class' => 'next'}, 'Next Month');
		$h->h3(Month_to_Text($month) . " $year");
	});
	$h->table({'class' => 'calendar'}, sub {
		$h->thead(sub {
			$h->tr(sub {
				foreach (qw(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)) {
					$h->th({'scope' => 'col'}, $_);
				}
			});
		});
		$h->tbody(sub {
			foreach my $week (@calendar) {
				$h->tr(sub {
					foreach my $day (@$week) {
						$h->td({'class' => ($day->month == $month) ? '' : 'other_month'}, sub {
							$h->span({'class' => 'date'}, $day->date);
							if ($day->events->[0]) {
								$h->dl({'class' => 'events'}, sub {
									foreach my $event (sort {$a->time <=> $b->time} @{$day->events}) {
										$h->dt({'class' => $event->calendar}, $event->time);
										$h->dd({'class' => $event->calendar}, sub {
											$h->a({'href' => "/news.asp?year=$year&amp;month=$month#event-" . $event->id}, $event->name);
										});
									}
								});
							}
						});
					}
				});
			}
		});
	});
}