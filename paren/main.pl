use warnings;
use strict;

my $str= ')()af)f123(';
#my $str= '()()()';

#iterative
sub paren {
    my ($str) = @_;
    my @stack;
    my @char = split('', $str);
    for my $ch (@char) {
        my $current = $stack[$#stack] || '';
        print $ch,':current:', $current, ':', join('|',@stack), "\n";
        if ($ch eq ')' && $current eq '(') {
            print "pop\n";
            pop @stack;
        }
        elsif ($ch eq ')' || $ch eq '(') {
            print "push $ch\n";
            push @stack, $ch;
        }
    }
    return scalar(@stack) == 0;
}

if (paren($str)) {
    print "true\n";
}
else {
    print "false\n";
}

