use warnings;
use strict;

my @shuffled;

sub shuffle {
    my %cards;
    $cards{$_} = $_ for (1..52);
    for my $i (1..52) {
        my $left = 53 - $i; # 52, 51, ... 1
        my @cards = keys(%cards);
        my $picked_i = int(rand($left));
        my $picked = $cards[ $picked_i ];
        print "picked: $picked\n";
        delete $cards{$picked};
        push @shuffled, $picked;
    }
}

sub better_shuffle {
    my @cards;
    $cards[$_] = $_ for (0..51);
    for my $i (0..51) {
        my $picked_i = int(rand(51 - $i)) + $i; # 51, 50, .. 0
        my $tmp = $cards[$picked_i];
        print "picked: $tmp\n";
        $cards[$picked_i] = $cards[$i];
        $cards[$i] = $tmp;
    }
    @shuffled = @cards;
}

#shuffle();
better_shuffle();
print join(',', @shuffled), "\n";

