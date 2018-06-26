#!/usr/bin/perl -w

use strict;
use warnings;

BEGIN {push(@INC, "c:\\inetpub\\wwwroot\\resources\\scripts");}
BEGIN {push(@INC, "c:\\inetpub\\wwwroot\\resources\\scripts\\calendar");}
BEGIN {push(@INC, "w:\\resources\\scripts\\calendar");}

use CGI;
use HTTP::Date;

my $cgi = new CGI;

require Calendar;
require Builder;
require Date::Calc;

my $year = $cgi->param('year') || (localtime)[5] + 1900;
my $month = $cgi->param('month') || (localtime)[4] + 1;
my $selected_day = $cgi->param('day') || 0;

if ($selected_day == 'today') {
	$selected_day = (localtime)[3];
}

print $cgi->header(-Last_modified => time2str());

my $month_name = Date::Calc::Month_to_Text($month);
my $calendar = Calendar::get_month($year, $month);
my $h = new Builder;

print do {
	$h->div({'class' => 'widget', 'id' => 'small_calendar'}, sub{
	$h->h4("$month_name $year");
		$h->table(sub {
			$h->thead(sub {
				$h->tr(sub {
					foreach (qw(S M T W T F S)) {
						$h->th($_);
					}
				});
			});
			$h->tbody(sub{
				foreach my $week (@$calendar) {
					$h->tr(sub {
						foreach my $day (@$week) {
							$h->td({'id' => 'small_calendar-date_' . $day->date, 'class' => (($day->date == $selected_day) ? ' selected' : '')}, $day->date);
						}
					});
				};
			});
		});
	});
};