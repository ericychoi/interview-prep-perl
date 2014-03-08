use strict;
use warnings;

my $str = 'abcd';

sub permute_with_chars {
    my ($chars_left) = @_;
    my @avail_only = grep { $_->{avail} } @$chars_left;
    if (scalar(@avail_only) == 1) {
        return $avail_only[0]->{c};
    }
    my @results;
    for my $current (@$chars_left) {
        if ($current->{avail}) {
            undef $current->{avail};
            my @subresults = permute_with_chars($chars_left);
            $current->{avail} = 1;
            map { push @results, $current->{c}.$_ } @subresults;
        }
    }
    return @results;
}

# treat $chars_left as a set then duplicate elements are okay
sub permute {
    my ($str) = @_;
    my (@chars_left, @results);
    push @chars_left, { c => $_, avail => 1 } for (split ('', $str));
    @results = permute_with_chars(\@chars_left);
    print join("\n", @results), "\n";
}

permute($str);
