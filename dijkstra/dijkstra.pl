#!/usr/bin/perl

use strict;
use warnings;

my $NUM_TEST = 1;
my $EDGE_RATIO = 0.5;
my $INFIN = 10000000;

my @vertex_list;
my @edge_list;

my $num_vertices = 6;

populate_vertices();
@edge_list = create_edges($num_vertices, \@vertex_list);
print_edges(@edge_list);
print "\n";

my $kb = $vertex_list[0];
$kb->{dist} = 0;
my @unvisited = @{$kb->{adj}};

while (1) {
    my $current = shift @unvisited;
    $current;
}

for my $neighbor (@{$kb->{adj}}) {
    $neighbor
}

sub populate_vertices {
    my $i = 1;
    for my $name ('A'..'Z') {
        push @vertex_list, { label => $name, adj => [], prev => {}, dist => $INFIN };
        if ($i++ == $num_vertices) { last; }
    }
}

sub create_edges {
    my ($num_vertices, $vl_ref) = @_;
    my @vertex_list = @$vl_ref;

    for my $v (@vertex_list) {
        my $number_links = int(rand($num_vertices) * $EDGE_RATIO);
        for (0..$number_links) {
            my $d = $vertex_list[int(rand($num_vertices))];
            if ($d->{label} ne $v->{label}) {
                my $edge = join(':', ( sort { $a cmp $b } ($v->{label}, $d->{label}) ));
                push @{$d->{adj}}, $v;
                push @{$v->{adj}}, $d;
                $edge_hash{$edge} = 1;
            }
        }
    }

    return sort { $a cmp $b } keys(%edge_hash);
}

sub print_edges{
    my @edge_list = @_;
    print join ('|', @edge_list)."\n";
}

