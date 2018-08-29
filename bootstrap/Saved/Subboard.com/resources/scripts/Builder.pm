package Builder;

use strict;
use warnings;

sub new {
	my ($class) = @_;
	
	my $self = {
		indent_level => 0,
		xhtml => 0,
		output => '',
	};
	
	bless $self, 'Builder';
	return $self;
}

our $AUTOLOAD;
sub AUTOLOAD {
	my $self = shift;
	my $name = $AUTOLOAD;
	$name =~ s/.*://;
	
	unless ($name eq uc($name)) { # Ensures it's not a system method like DESTROY
		return $self->_tag2($name, @_);
	}
}

sub _tag2 {
	my $self = shift;
	my $name = shift;
	my ($text, $block, %attrs);
	
	foreach my $arg (@_) {
		if (ref($arg) eq 'CODE') {
			$block = $arg;
		}
		elsif (ref($arg) eq 'HASH') {
			@attrs{keys %$arg} = values %$arg;
		}
		elsif ($arg) {
			$text .= $arg;
		}
	}
	
	$self->_indent();
	if (defined $block) {
		$self->_start_tag($name, \%attrs);
		$self->_newline();
		$self->_nested_structures($block);
		$self->_indent();
		$self->_end_tag($name);
	}
	elsif (defined $text) {
		$self->_start_tag($name, \%attrs);
		$self->_text($text);
		$self->_end_tag($name);
	}
	else {
		$self->_start_tag($name, \%attrs, 1);
	}
	$self->_newline();
	
	return $self->{output};
}

sub _start_tag {
	my ($self, $name, $attrs_ref, $is_close) = @_;
	
	$self->{output} .= "<$name";
	$self->_insert_attributes($attrs_ref);
	if ($is_close and $self->{xhtml}) {$self->{output} .= '/';}
	$self->{output} .= '>';
}

sub _end_tag {
	my ($self, $name) = @_;
	$self->{output} .= "</$name>";
}

sub _insert_attributes {
	my ($self, $attrs_ref) = @_;
	
	if (defined $attrs_ref) {
		while (my ($attr, $val) = each(%$attrs_ref)) {
			if (defined $val and !($val eq '')) {
				$self->{output} .= " $attr='$val'";
			}
		}
	}
}

sub _nested_structures {
	my $self = shift;
	my $block = shift;
	
	$self->{indent_level} += 1;
	&$block($self);
	$self->{indent_level} -= 1;
}

sub _text {
	(shift)->{output} .= shift;
}

sub _newline {
	(shift)->{output} .= "\n";
}

sub _indent {
	my $self = shift;
	$self->{output} .= "\t" x $self->{indent_level};
}

1;