use Node;

use warnings;
use strict;

sub init {
  my $nodes = {};
  for (qw(a b c d f h i)) {
    $nodes->{$_} = Node->new(label => $_);
  }
  $nodes->{b}{L} = $nodes->{c};
  $nodes->{b}{R} = $nodes->{d};
  $nodes->{d}{L} = $nodes->{a};
  $nodes->{a}{L} = $nodes->{f};
  $nodes->{f}{R} = $nodes->{i};
  $nodes->{d}{R} = $nodes->{h};
  return $nodes->{b};
}

sub sample_tree {
  my $nodes = {};
  for ('a'..'i') {
    $nodes->{$_} = Node->new(label => $_);
  }
  $nodes->{f}{L} = $nodes->{b};
  $nodes->{b}{L} = $nodes->{a};
  $nodes->{b}{R} = $nodes->{d};
  $nodes->{d}{L} = $nodes->{c};
  $nodes->{d}{R} = $nodes->{e};
  $nodes->{f}{R} = $nodes->{g};
  $nodes->{g}{R} = $nodes->{i};
  $nodes->{i}{L} = $nodes->{h};
  return $nodes->{f};
}

sub in_order {
  my ($n) = @_;
  my @s = ();
  while (defined $n || scalar(@s) != 0) {
    if (defined $n) {
      push @s, $n;
      $n = $n->L();
    }
    else {
      $n = pop @s;
      print $n->label, " ";
      $n = $n->R;
    }
  }
  print "\n";
}

sub pre_order {
  my ($n) = @_;
  my @s = ($n);
  while (scalar(@s) != 0) {
    $n = pop @s;
    print $n->label, ' ';
    if (defined ($n->R)) {
      push @s, $n->R;
    }
    if (defined ($n->L)) {
      push @s, $n->L;
    }
  }
  print "\n";
}

sub post_order {
  my ($n) = @_;
  my @s = ();
  my $visited;
  while (defined $n || scalar(@s) != 0) {
    if (defined $n) {
      push @s, $n;
      $n = $n->L;
    }
    else {
      my $m = $s[$#s];
      if (defined $m->R && $visited != $m->R) {
        $n = $m->R;
      }
      else {
        print $m->label, ' ';
        pop @s;
        $visited = $m;
      }
    }
  }
  print "\n";
}

my $root = init();
print "in_order: ";
in_order($root);
print "in_order (sample_tree): ";
in_order(sample_tree());

print "pre_order: ";
pre_order($root);
print "pre_order (sample_tree): ";
pre_order(sample_tree());

print "post_order: ";
post_order($root);
print "post_order (sample_tree): ";
post_order(sample_tree());

## TODO: deserialize tree?
