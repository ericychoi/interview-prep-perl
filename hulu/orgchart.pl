#!/usr/bin/perl

use Data::Dumper;
use strict;
use warnings;

my ($input, $output) = @ARGV;
open my $in_fh, '<', $input or die 'cannot open input file';
open my $out_fh, '>', $output or die 'cannot open output file';


# a list for all the names
my ($case_number, $total_case) = (0, undef);
while(my $line = <$in_fh>) {
    my %name_list = ();
    chomp $line;
    if (!$case_number) {
        $total_case = $line;
    }
    else {
        my @person_words = split('--', $line);
        for my $p (@person_words) {
            my ($name, $boss, $title, $year) = split(',', $p);
            $name_list{$name} = { name => $name, boss => $boss, title => $title, year => $year };
        }
        construct_org(\%name_list);

        # find an employee who has NULL boss
        my ($null_boss) = grep { $name_list{$_}->{boss} && $name_list{$_}->{boss} eq 'NULL' }
          keys (%name_list);

        print {$out_fh} "Case #", $case_number, "\n";
        print_org($name_list{$null_boss}, 1);
        print "\n";
    }
    $case_number++;
}

sub construct_org {
    my ($list_ref) = @_;
    my $i = 0;
    for my $name (keys %$list_ref) {
        my $employee = $list_ref->{$name};
        if (my $boss = $list_ref->{$employee->{boss}}) {
            if ($boss->{under}) {
                push @{$boss->{under}}, $employee;
            }
            else {
                $boss->{under} = [ $employee ];
            }
        }
    }
}

sub print_org {
    my ($node, $level) = @_;
    printEmployee($node->{name}, $node->{title}, $node->{year});
    if ($node->{under}) {
        for my $under (sort {$a->{name} cmp $b->{name}} @{$node->{under}}) {
            print {$out_fh} '-' x $level;
            print_org($under, $level+1);
        }
    }
}

sub printEmployee {
    my ($name, $title, $year) = @_;
    printf {$out_fh} "%s (%s) %i\n", $name, $title, $year;
}

close ($in_fh);
close ($out_fh);
