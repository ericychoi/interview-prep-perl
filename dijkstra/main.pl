my $NUM_TEST = 1;
my $INF = 10000000;

my $num_vertices = 4;

my @vertex_list;
my $i = 1;
for my $name ('A'..'Z') {
    push @vertex_list, create_vertex($name);
    if ($i++ == $num_vertices) { last; }
}
create_links();
print_file();

sub create_vertex {
    my ($name) = @_;
    return { label => $name, adj => {}, prev => undef, dist => $INF };
}

sub create_links {
    for my $v (@vertex_list) {
        my $number_links = int(rand($num_vertices));
        for (0..$number_links) {
            my $vt = $vertex_list[int(rand($num_vertices))];
            $v->{adj}{$vt->{label}} = $vt; # dupes are okay
        }
    }
}

sub print_file {
    for my $v (@vertex_list) {
        for my $vl (keys %{$v->{adj}}) {
            print $v->{label}, ':', $vl, "\n";
        }
    }
}
