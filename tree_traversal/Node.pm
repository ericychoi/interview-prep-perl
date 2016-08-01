package Node;

use warnings;
use strict;

sub new {
  my ($class, %args) = @_;
  return bless {L => undef, R => undef, label => undef, %args}, $class;
}

sub L { $_[0]->{L} }
sub R { $_[0]->{R} }
sub label { $_[0]->{label} }

1;
