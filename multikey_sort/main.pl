use warnings;
use strict;

use Data::Dumper;

my @data = (
    {
        given => 'd',
        sur => 'd'
    },
    {
        given => 'a',
        sur => 'd'
    },
    {
        given => 'z',
        sur => 'd',
    },
    {
        given => 'a',
        sur => 'z'
    }
);

my @sorted = sort {
    $a->{sur} ne $b->{sur} ? $a->{sur} cmp $b->{sur} : $a->{given} cmp $b->{given}
#    $a->{sur} cmp $b->{sur}
} @data;

print Data::Dumper::Dumper(\@sorted), "\n";
