use strict;
use warnings;

use Storable qw(dclone);
use Data::Dumper;

my %node = (
    v => undef,
    l => undef,
    r => undef,
    visited => undef
);

#my @values = qw(1 2 3 4 6 8 10);
my @values = qw(3 4 2 1);

sub make_node {
    my ($v, $l, $r) = @_;
    @node{qw(v l r)} = ($v, $l, $r);
    return dclone(\%node);
}

sub create_binary_tree {
    my $root = make_node(6, undef, undef);
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
sub bfs_traverse_tree {
    my ($root, $func) = @_;
    my @nodes = ($root);
    while (scalar(@nodes) > 0) {
        $func->(\@nodes);
    }
}

sub bfs_eval_node {
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

#DFS
sub dfs_inorder_traverse_tree {
    my ($root, $visit) = @_;
    my @stack;
    my $node = $root;
    my $i= 0;
    while ($node && !$node->{visited}) {
        if ($node->{l} && !$node->{l}{visited}) {
            push @stack, $node;
            $node = $node->{l};
        }
        else {
            $visit->($node);
            if ($node->{r} && !$node->{r}{visited}) {
                $node = $node->{r};
            }
            else {
                $node = pop @stack;
            }
        }
    }
}

sub dfs_preorder_traverse_tree {
    my ($root, $visit) = @_;
    my @stack;
    my $node = $root;
    my $i= 0;
    while ($node && !$node->{visited}) {
        print $node->{v}, '|', join(':', map {$_->{v}} @stack), "\n";
        $visit->($node);
        if ($node->{l} && !$node->{l}{visited}) {
            if ($node->{r}) {
                push @stack, $node->{r};
            }
            $node = $node->{l};
        }
        else {
            if ($node->{r}) {
                $node = $node->{r};
            }
            else {
                $node = pop @stack;
            }
        }
    }
}

sub dfs_postorder_traverse_tree {
    my ($root, $visit) = @_;
    my @stack;
    my $node = $root;
    my $i= 0;
    while ($node && !$node->{visited}) {
        print $node->{v}, '|', join(':', map {$_->{v}} @stack), "\n";
        if ($node->{l} && !$node->{l}{visited}) {
            push @stack, $node;
            if ($node->{r}) {
                push @stack, $node->{r};
            }
            $node = $node->{l};
        }
        elsif ($node->{r} && !$node->{r}{visited}) {
            push @stack, $node;
            $node = $node->{r};
        }
        else {
            $visit->($node);
            $node = pop @stack;
        }
    }
}



sub visited {
    my ($node) = @_;
    print 'visiting ', $node->{v}, "\n";
    $node->{visited} = 1;
}

my $tree = create_binary_tree();
#bfs_traverse_tree($tree, \&bfs_eval_node);
#dfs_inorder_traverse_tree($tree, \&visited);
#dfs_preorder_traverse_tree($tree, \&visited);
#dfs_postorder_traverse_tree($tree, \&visited);

