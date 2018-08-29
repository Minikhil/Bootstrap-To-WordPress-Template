#!/usr/bin/perl -w

use strict;
use warnings;

BEGIN {push(@INC, "c:\\inetpub\\wwwroot\\resources\\scripts");}
BEGIN {push(@INC, "c:\\inetpub\\wwwroot\\resources\\scripts\\calendar");}
BEGIN {push(@INC, "w:\\resources\\scripts\\calendar");}

use CGI;
use Data::Dumper;
use Date::Calc;
use Calendar;
use Builder;

my $cgi = new CGI;
print $cgi->header;
my $this_year = $cgi->param('year');
my $this_month = $cgi->param('month');

unless ($this_year ne "" and $this_month ne "") {
	($this_year, $this_month, $_) = Date::Calc::Today();
}

my ($next_year, $next_month) = Date::Calc::Add_Delta_YM($this_year, $this_month, 1, 0, 1);
my ($prev_year, $prev_month) = Date::Calc::Add_Delta_YM($this_year, $this_month, 1, 0, -1);

my $month = Calendar::get_month($this_year, $this_month);
my $divisions = Event::divisions;

my $h = Builder->new;

print do {
	$h->div({'id' => 'key'}, sub {
		$h->ul(sub {
			foreach my $division (@$divisions) {
				$h->li({'class' => $division->abbreviation}, sub {
					$h->a({'href' => $division->home_page, 'target' => '_blank'}, $division->name);
				});
			}
		});
	});
	
	$h->div({'class' => 'calendar_controls'}, sub {
		$h->a({'href' => "calendar.asp?year=$prev_year&amp;month=$prev_month", 'class' => 'prev'}, 'Previous Month');
		$h->a({'href' => "calendar.asp?year=$next_year&amp;month=$next_month", 'class' => 'next'}, 'Next Month');
		$h->h3(Date::Calc::Month_to_Text($this_month) . " $this_year");
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
			foreach my $week (@$month) {
				$h->tr(sub {
					foreach my $day (@$week) {
						$h->td({'class' => ($day->month == $this_month) ? '' : 'other_month'}, sub {
							$h->span({'class' => 'date'}, $day->date);
							if ($day->events->[0]) {
								$h->dl({'class' => 'events'}, sub {
									foreach my $event (sort {$a->time_start <=> $b->time_start} @{$day->events}) {
										$h->dt({'class' => $event->division}, Event::time_to_12hr($event->time_start)) unless $event->is_all_day;
										$h->dd({'class' => $event->division}, sub {
											$h->a({'href' => "/news.asp?year=$this_year&amp;month=$this_month#event-" . $event->id}, $event->title);
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