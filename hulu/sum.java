import java.io.file;

class Sum{
    public static void main (String[] args) {
        String readFile = args[0];
        String writeFile = args[1];
        
    }
}
use strict;
use warnings;

my ($read_file, $write_file) = @ARGV;
$read_file or die "no suitable file found";

open(my $fh, '<', $read_file);
open(my $wfh, '>', $write_file);

my ($case_number, $total_case) = (0, undef);
while (my $line = <$fh>) {
    chomp $line;
    if (!$case_number) {
        $total_case = $line;
    }
    else {
        my @numbers = split(/\s+/, $line);
        if (scalar (@numbers) != 2) {
            die 'invalid format encountered';
        }
        else {
            print $wfh 'Case #', $case_number, "\n", $numbers[0] + $numbers[1], "\n";
        }
    }
    $case_number++;
}

if ($total_case != $case_number-1) {
    print "case number mismatch?!\n";
}
close($fh);
close($wfh);
