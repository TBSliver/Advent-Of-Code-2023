package Solver::Day01::Puzzle01;

use Moo;
use Devel::Dwarn;

sub run {
    my ($self, $string) = @_;
    my @data = split "\n", $string;

    my $total = 0;

    for my $line (@data) {
        my ($first_val, $second_val) = $line =~ /^.*?(\d)(?:.*(\d)|.*).*?$/;

        $second_val = $first_val unless (defined $second_val);

        my $final_val = "${first_val}${second_val}";

        $total += $final_val;
    }

    return $total;
}

1;
