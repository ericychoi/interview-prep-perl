use strict;
use warnings;

use Data::Dumper;

my $str = '120';

my %number_map;

sub phone_with_chars {
    my ($chars_left) = @_;
    my @avail_only = grep { $_->{avail} } @$chars_left;
    if (scalar(@avail_only) == 1) {
        print join ('|', values %{$number_map{$avail_only[0]->{c}}}), "\n";
        return values %{$number_map{$avail_only[0]->{c}}};
    }
    my @results;
    for my $current (@$chars_left) {
        if ($current->{avail}) {
            undef $current->{avail};
            my @subresults = phone_with_chars($chars_left);
            print Data::Dumper::Dumper(\@subresults);
            #$current->{avail} = 1;
            for my $l (values %{$number_map{$current->{c}}}) {
                map { push @results, $l.$_ } @subresults;
            }
        }
    }
    return @results;
}

# treat $chars_left as a set then duplicate elements are okay
sub phone {
    my ($str) = @_;
    my (@chars_left, @results);
    push @chars_left, { c => $_, avail => 1 } for (split ('', $str));
    @results = phone_with_chars(\@chars_left);
    print join("\n", @results), "\n";
}

sub init {
    my $i = 2;
    my $char_i = 0;
    for my $char (qw(A B C D E F G H I J K L M N O P R S T U V W X Y)) {
        $number_map{$i}{$char_i%3} = $char;
        $char_i++;
        if ($char_i % 3 == 0) {
            $i++;
        }
    }
    map { $number_map{$_} = { 0 => $_ }; } qw( 0 1 );
}
init();
print Data::Dumper::Dumper(\%number_map);
phone($str);
