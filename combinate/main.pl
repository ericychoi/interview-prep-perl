use strict;
use warnings;

my $str = 'abcd';

sub combination_with_chars {
    my ($chars_left, $results) = @_;
    my @avail_only = grep { $_->{avail} } @$chars_left;
    if (scalar(@avail_only) == 1) {
        undef $avail_only[0]->{avail};
        push @$results, $avail_only[0]->{c};
        return;
    }
    my @results;
    for my $current (@$chars_left) {
        if ($current->{avail}) {
            undef $current->{avail};
            combination_with_chars($chars_left, $results);
            map { push @$results, $current->{c}.$_ } @$results;
            push @$results, $current->{c};
        }
    }
    return;
}

# treat $chars_left as a set then duplicate elements are okay
sub combination {
    my ($str) = @_;
    my (@chars_left, @results);
    push @chars_left, { c => $_, avail => 1 } for (split ('', $str));
    combination_with_chars(\@chars_left, \@results);
    print join("\n", @results), "\n";
}

combination($str);
