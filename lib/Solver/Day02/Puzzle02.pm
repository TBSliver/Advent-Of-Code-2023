package Solver::Day02::Puzzle02;

use Moo;
use Devel::Dwarn;

sub run {
    my ($self, $games) = @_;

    my $sum = 0;

    LINE:
    for my $line (split(/[\r\n]+/, $games)) {
        my ($game_id, $pulls) = $line =~ /^Game (\d+):(.*)$/g;

        my $max = {};

        for my $pull (split(";", $pulls)) {
            $pull =~ s/^\s*//;

            for my $cubes (split(",", $pull)) {
                $cubes =~ s/^\s*//;
                my ($count, $colour) = $cubes =~ /^(\d+) (.*)$/;

                unless (exists $max->{$colour} && $max->{$colour} > $count) {
                    $max->{$colour} = $count;
                }
            }
        }

        my $power = 0;
        for my $val (values %$max) {
            if ($power <= 0) {
                $power = $val;
            } else {
                $power *= $val;
            }
        }
        # if we got here, then the line was valid
        $sum += $power;
    }

    return $sum;
}

1;
