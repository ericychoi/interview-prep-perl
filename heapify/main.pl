use strict;
use warnings;

use Storable qw(dclone);
use Data::Dumper;

my %node = (
    v => undef,
    l => undef,
    r => undef
);

my @values = qw(1 2 3 4 6 8 10);

sub make_node {
    my ($v, $l, $r) = @_;
    @node{qw(v l r)} = ($v, $l, $r);
    return dclone(\%node);
}

sub create_binary_tree {
    my $root = make_node(5, undef, undef);
    for my $cv (@values) {
        insert_node($root, make_node($cv, undef, undef));
    }
    return $root;
}

sub insert_node {
    my ($tree, $node) = @_;
    if ($tree->{v} <= $node->{v}) {
        if ($tree->{r}) {
            insert_node($tree->{r}, $node);
        }
        else {
            $tree->{r} = $node;
        }
    }
    else {
        if ($tree->{l}) {
            insert_node($tree->{l}, $node);
        }
        else {
            $tree->{l} = $node;
        }
    }
}

# BFS
sub traverse_tree {
    my ($root, $func) = @_;
    my @nodes = ($root);
    while (scalar(@nodes) > 0) {
        $func->(\@nodes);
    }
}

sub eval_node {
    my ($r) = @_;
    my $cn = shift @$r;
    print $cn->{v}, "\n";
    if ($cn->{l}) {
        push @$r, $cn->{l}
    }
    if ($cn->{r}) {
        push @$r, $cn->{r}
    }
}

my $tree = create_binary_tree();
traverse_tree($tree, \&eval_node);

