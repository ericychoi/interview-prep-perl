#!/usr/bin/perl

use strict;
use warnings;

my $NUM_TEST = 5;
my $EDGE_RATIO = 0.5;

my ($write_file) = @ARGV;

open(my $wfh, '>', $write_file);

sub create_test {
    my $num_vertices = 6;

    my @vertex_list;
    my @edge_list;
    my $i = 1;
    for my $name ('A'..'Z') {
        push @vertex_list, $name;
        if ($i++ == $num_vertices) { last; }
    }
    @edge_list = create_edges($num_vertices, \@vertex_list);
    print_edges(@edge_list);
}

for (1..$NUM_TEST) {
    create_test();
}

close($wfh);

sub create_edges {
    my ($num_vertices, $vl_ref) = @_;
    my @vertex_list = @$vl_ref;

    my %edge_hash;
    for my $v (@vertex_list) {
        my $number_links = int(rand($num_vertices) * $EDGE_RATIO);
        for (0..$number_links) {
            my $d = $vertex_list[int(rand($num_vertices))];
            if ($d ne $v) {
                my $edge = join(':', ( sort { $a cmp $b } ($v, $d) ));
                $edge_hash{$edge} = 1;
            }
        }
    }
    return sort { $a cmp $b } keys(%edge_hash);
}

sub print_edges{
    my @edge_list = @_;
    print {$wfh} join ('|', @edge_list)."\n";
}
