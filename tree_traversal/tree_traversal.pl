use warnings;
use strict;

my $tree; # pointer to top of tree

my @stack. @queue;

sub tree_walker {
    if ($isBFS) {
        push @queue, $tree;
    }
    else {
        unshift @stack, $tree;
    }
    while(@stack) {
        eval_node();
    }
}

sub eval_node {
    my $list;
    if ($isBFS) {
        $list = \@queue;
    }
    else {
        $list = \@stack;
    }
    $node = shift @$list;
    if ($isBFS) {
        push @$list, @{$node->{children}} if $node->{children};
    }
    else {
        unshift @$list, @{$node->{children}} if $node->{children};
    }
    print_node($node);
}

##

sub print_node {
    print $node->{content}, "\n";
}

#recursive

sub eval_node_rec {
    print_node($node);
    for my $child (@{$node->{children}}) {
        eval_node_rec($child);
    }
}

sub tree_walker_rec {
    eval_node_rec($tree);
}

# what about BFS

