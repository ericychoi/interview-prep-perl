use strict;
use warnings;

use Data::Dumper;

my @array = qw (1 2 3 4 5 6 7 8 9 10);

my $int = 8;

print search($int, 0, $#array), "\n";

sub search {
    my ($int, $start_i, $end_i) = @_;
    print "looking for $int in ", $start_i, ":", $end_i, "\n";
    my $mid = int(($end_i - $start_i) / 2) + $start_i;
    if ($array[$mid] == $int) {
        print "found $mid", "\n";
        return $mid;
    }
    elsif ($array[$mid] < $int) {
        print "m: $mid\n";
        return search($int, $mid + 1, $end_i);
    }
    else {
        print "m: $mid\n";
        return search($int, $start_i, $mid - 1);
    }
}
