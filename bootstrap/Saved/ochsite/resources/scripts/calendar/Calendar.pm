package Calendar;

use strict;
use warnings;

use Class::Struct;
use Iterator;
use Date::Calc qw(:all);
use Event;

use constant {
	SUNDAY    => 1,
	MONDAY    => 2,
	TUESDAY   => 3,
	WEDNESDAY => 4,
	THURSDAY  => 5,
	FRIDAY    => 6,
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

sub get_month ($$) {
	my ($year, $month) = @_;
	
	# Find beginning of calendar
	my $first_dow = Day_of_Week($year, $month, 1);
	my ($y, $m, $d) = Add_Delta_Days($year, $month, 1, - $first_dow);
	
	# Rather than finding the exact end of the calendar, we just err on the side of a longer month.
	my ($y_end, $m_end, $d_end) = Add_Delta_YMD($year, $month, Days_in_Month($year, $month), 0, 0, 7);
	
	my $events = Event::in_date_range(Event::date_to_iso($y, $m, $d), Event::date_to_iso($y_end, $m_end, $d_end));
	my $events_itr = Iterator->new($events);
	my @current_events;
	
	my @weeks;
	do {
		my @days;
		for (my $dow = SUNDAY; $dow <= SATURDAY; $dow++) {
			my $iso_date = Event::date_to_iso($y, $m, $d);
			my $day = Day->new(year=>$y, month=>$m, date=>$d, day_of_week=>$dow);
			push(@days, $day);
			
			# Add current events
			for (my $itr = Iterator->new(\@current_events); my $event = $itr->move_next;) {
				if ($event->date_end ge $iso_date) {
					push(@{$day->events}, $event);
				}
				else {$itr->delete;}
			}
			
			# Add new events
			while ($events_itr->has_next and $events_itr->peek_next->date_start le $iso_date) {
				my $event = $events_itr->move_next;
				push(@{$day->events}, $event);
				push(@current_events, $event);
			}
			
			($y, $m, $d) = Add_Delta_Days($y, $m, $d, 1);
		}
		push(@weeks, \@days);
	}
	while ($m == $month);
	
	return \@weeks;
}

1;