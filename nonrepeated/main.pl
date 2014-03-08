use strict;
use warnings;

#my $str = 'total';
my $str = $ARGV[0];

sub nonrepeated_hash {
    my ($str) = @_;
    my @char = split('', $str);
    my %count;
    map { $count{$_}++; } @char;
    for my $ch (@char) {
        return $ch if $count{$ch} == 1;
    }
    return undef;
}

sub nonrepeated {
    my ($str) = @_;
    my @char = split('', $str);
    FIRST: for (my $i = 0; $i < $#char; $i++) {
        for (my $j = $i + 1; $j < $#char; $j++) {
            next FIRST if ($char[$i] eq $char[$j]);
        }
        return $char[$i];
    }
    return undef;
}

print "for $str:", nonrepeated_hash($str), "\n";
print "for $str:", nonrepeated($str), "\n";
