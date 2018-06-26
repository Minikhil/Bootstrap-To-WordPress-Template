package HTMLBuilder;

use strict;
use warnings;

sub new {
	my ($class) = @_;
	
	my $self = {
		indent_level => 0,
		xhtml => 0,
		output => '',
	};
	
	bless $self, 'HTMLBuilder';
	return $self;
}

sub inline ($$\%$) {
	my $self = shift; # 1st arg
	my $name = shift; # 2nd arg
	my $contents = pop; # last arg
	my $attrs_ref = shift; # remaining arg, optional
	my $o = \$self->{output};
	my $root = ($$o eq '');
	
	$$o .= "<$name";
	
	while (my($attr, $val) = each(%$attrs_ref)) {
		$$o .= " $attr='$val'";
	}
	
	$$o .= '>';
	
	if (ref($contents) eq 'CODE') {
		&$contents($self);
	}
	else {
		$$o .= $contents;
	}
	$$o .= "</$name>";
	
	if ($root) {my $t = $$o;$$o = ''; $o = \$t;}
	return $$o;
}

sub block ($$$\%$) {
	my $self = shift; # 1st arg
	my $name = shift; # 2nd arg
	my $contents = pop; # last arg
	my $attrs_ref = shift; # remaining arg, optional
	my $o = \$self->{output};
	my $root = ($$o eq '');
	
	$$o .= ('	' x $self->{indent_level}) . "<$name";
	
	while (my($attr, $val) = each(%$attrs_ref)) {
		$$o .= " $attr='$val'";
	}
	
	$$o .= ">\n";
	
	$self->{indent_level}++;
	
	if (ref($contents) eq 'CODE') {
		&$contents($self);
	}
	else {
		$$o .= ('	' x $self->{indent_level}) . $contents;
	}
	
	$self->{indent_level}--;
	
	$$o .= "\n" . ('	' x $self->{indent_level}) . "</$name>";
	
	if ($root) {my $t = $$o;$$o = ''; $o = \$t;}
	return $$o;
}

sub short ($$\%) {
	my $self = shift; # 1st arg
	my $name = shift; # 2nd arg
	my $attrs_ref = shift; # remaining arg, optional
	my $o = \$self->{output};
	my $root = ($$o eq '');
	
	$$o .= "<$name";
	
	while (my($attr, $val) = each(%$attrs_ref)) {
		$$o .= " $attr='$val'";
	}
	
	$$o .= '>';
	
	if ($root) {my $t = $$o;$$o = ''; $o = \$t;}
	return $$o;
}

sub text ($$) {
	my $self = shift;
	my $contents = shift;
	my $o = \$self->{output};
	my $root = ($$o eq '');
	
	$$o .= $contents;
	
	if ($root) {my $t = $$o;$$o = ''; $o = \$t;}
	return $$o;
}

1;