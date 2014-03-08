use warnings;
use strict;

sub selection_sort {
    my ($r) = @_;
    if (ref($r) ne 'ARRAY' || scalar(@$r) == 0) {
        die "no sort possible";
    }
    if (scalar (@$r) == 1) {
        return;
    }

    for (my $i = 0; $i < scalar(@$r); $i++) {
        my $minI = $i;
        for (my $j = $i+1; $j < scalar(@$r); $j++) {
            if ($r->[$minI] > $r->[$j]) {
                $minI = $j;
            }
        }
        my $tmp = $r->[$i];
        $r->[$i] = $r->[$minI];
        $r->[$minI] = $tmp;
    }
}

my $ar = [qw(10 -1 3 4 2 12 555 12 19787)];
print 'before: ', join(',', @$ar), "\n";
selection_sort($ar);
print 'after: ', join(',', @$ar), "\n";
