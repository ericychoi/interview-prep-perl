use warnings;
use strict;

#my $str = 'abcdf1331aba';
my $str = 'abcdf';

sub string_dupe {
    my ($str) = @_;
    my %count;
    my @char = split('', $str);
    map { return 1 if ($count{$_}++) } @char;
    return undef;
}

if (string_dupe($str)) {
    print "true\n";
}
else {
    print "false\n";
}
