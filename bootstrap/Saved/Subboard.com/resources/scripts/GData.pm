package GData;

use strict;
use warnings;

use Cache::FileCache; my $cache = new Cache::FileCache();
use Class::Struct;
use Date::Calc qw(:all);
use JSON::Syck;
use LWP; my $ua = LWP::UserAgent->new;

use Thread qw(async);

struct Event =>
{
	id => '$',
	calendar => '$',
	name => '$',
	url => '$',
	time => '$',
	dates => '@',
};

struct Day =>
{
	year => '$',
	month => '$',
	date => '$',
	day_of_week => '$',
	events => '@',
};

my $cache_persistence = "1 hour";

#			 	Abbr	  Name 				    Google ID					  URL
my %sources = ('sbi',   ['Sub Board I, Inc',   'qe433ccpcpej46ita926t26hh8', '/'],
			   'int',   ['Internal Events',    'fssmihkburkfpjcdrpgac8qboc', '/staff_resource/index.aspx'],
			   'lab',   ['Clinical Lab',       '8icjfj9bn6biphu194taaidn08', 'http://clinicallab.buffalo.edu'],
			   'gen',   ['Generation',         '8k5peijb3ohc2i3buo93tckhto', 'http://generation.buffalo.edu'],
               'he',    ['Health Education',   'l6bteshhpdaor2gst4r0nfbckg', 'http://healtheducation.buffalo.edu'],
               'legal', ['Legal Assistance',   'nofhq0fl4jljvm9hruss01h7kg', 'http://legalassistance.buffalo.edu'],
               'och',   ['Off-Campus Housing', 'hikipb20plnftppbttvfef6usc', 'http://offcampushousing.buffalo.edu'],
               'pharm', ['Pharmacy',           '738ouahu8skfl3qe2in47iulrk', 'http://pharmacy.buffalo.edu'],
               'tick',  ['Ticket Office',      'boq6t6t3rga9i1hpt6rr3pujig', 'http://ticketoffice.buffalo.edu'],
               'wrub',  ['WRUB',               'pv6p2psp9vn2s0t1qh9kigu04s', 'http://wrub.buffalo.edu']);

sub sources {return \%sources;}

sub getEvents (\@\@\@) {
	my ($sources_ref, $start, $end) = @_;
	
	my ($start_year, $start_month, $start_day) = @$start;
	my ($end_year, $end_month, $end_day) = @$end;
	
	my @all_events;
	my %used;
	
	foreach my $source (@$sources_ref) {
		my @source_events;
		
		my $gcalendar_cache_key = "gcalendar-$source-$start_year-$start_month";
		my $cached_gcalendar = $cache->get($gcalendar_cache_key);
		
		if (defined $cached_gcalendar) {
			@source_events = @$cached_gcalendar;
		}
		else {
			my $request = HTTP::Request->new(GET => 'http://www.google.com/calendar/feeds/' . $sources{$source}->[1] . '@group.calendar.google.com/public/full?start-min=' .
		    	sprintf("%d-%02d-%02d", ($start_year, $start_month, $start_day)) . '&start-max=' . sprintf("%d-%02d-%02d", ($end_year, $end_month, $end_day)) . '&alt=json');
		    my $response = $ua->request($request);
		    my $gdata = JSON::Syck::Load($response->content);
		    my $events = $gdata->{"feed"}->{"entry"};
		    
			foreach (@{$events}) {
				my $occurrences = $_->{'gd$when'};
				
				my ($h, $m) = ($occurrences->[0]->{'startTime'} =~ /T(\d\d):(\d\d)/);
				my $start_time;
				if (defined $m) {
					my $ampm = ($h < 12) ? 'AM' : 'PM';
					$h = ($h + 11) % 12 + 1;
					$start_time = "$h:$m $ampm";
				}
				else {
					$start_time = "All day";
				}
				
				my $event = Event->new(id => ($_->{'gCal$uid'}{'value'} =~ /(.*)@/),
				                       name => $_->{'title'}{'$t'},
				                       time => $start_time,
				                       url => $_->{'content'}{'$t'},
				                       calendar => $source);
				
				foreach (@$occurrences) {
					my ($date) = (defined $m) ? ($_->{'startTime'} =~ /(\d\d)T/) : ($_->{'startTime'} =~ /(\d\d)$/);
					push(@{$event->dates}, $date);
				}
				push(@source_events, $event);
			}
			
			$cache->set($gcalendar_cache_key, \@source_events, $cache_persistence);
		}
		push(@all_events, \@source_events);
		$used{$source} = 1 if scalar @source_events;
	}
	
	(\@all_events, \%used);
}

sub getDaysWithEvents (\@\@\@) {
	my ($sources_ref, $start, $end) = @_;
	my ($start_year, $start_month, $start_day) = @$start;
	
	my ($all_events_ref, $used_ref) = getEvents(@$sources_ref, @$start, @$end);
	
	my @days;
	my $days_in_month = Days_in_Month($start_year, $start_month);
	for (my ($d, $dow) = (1, Day_of_Week($start_year, $start_month, 1)); $d <= $days_in_month; $d++) {
		push(@days, Day->new(year => $start_year, month => $start_month, date => $d, day_of_week => $dow));
		$dow = $dow % 7 + 1;
	}
	
	foreach my $source_events (@$all_events_ref) {
		foreach my $event (@$source_events) {
			foreach (@{$event->dates}) {
				push(@{$days[$_-1]->events}, $event);
			}
		}
	}
	
	return (\@days, $used_ref);
}

1;