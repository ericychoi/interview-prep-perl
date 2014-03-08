use strict;
use warnings;

my $str = "Do or do not, there is no try.";
sub reverse_words {
    my ($str) = @_;
    my $result = '';
    my @words = split /\s/, $str;
    return join ' ', (reverse @words);
}

print reverse_words($str), "\n";
