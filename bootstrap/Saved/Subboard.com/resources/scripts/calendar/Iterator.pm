package Iterator;

use strict;
use warnings;

sub new { # Takes an array ref
	my $class = shift;
	my $array = shift;
	
	my $self = {array => $array, i => -1};
	
	bless($self, $class);
	return $self;
}

sub has_next {
	my $self = shift;
	return (($self->{i} + 1) < scalar( @{$self->{array}} ));
}

sub move_next {
	my $self = shift;
	
	$self->{i}++;
	
	return $self->{array}->[$self->{i}];
}

sub peek_next {
	my $self = shift;
	return $self->{array}->[$self->{i}+1];
}

sub current {
	my $self = shift;
	return $self->{array}->[$self->{i}];
}

# sub set ($) {
# 	my $self = shift;
# 	$self->{array}->[$self->{index}] = shift;
# }
# 
# sub insert ($) {
# 	my $self = shift;
# }

sub delete {
	my $self = shift;
	splice(@{$self->{array}}, $self->{i}, 1);
}

1;