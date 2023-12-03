package Solver::Day02::Puzzle01;

use Moo;
use Devel::Dwarn;

my $bag = {
  red   => 12,
  green => 13,
  blue  => 14,
};


sub run {
    my ($self, $games) = @_;

    my $sum = 0;

    LINE:
    for my $line (split(/[\r\n]+/, $games)) {
        my ($game_id, $pulls) = $line =~ /^Game (\d+):(.*)$/g;

        for my $pull (split(";", $pulls)) {
            $pull =~ s/^\s*//;

            for my $cubes (split(",", $pull)) {
                $cubes =~ s/^\s*//;
                my ($count, $colour) = $cubes =~ /^(\d+) (.*)$/;

                # Dwarn $colour;
                # Dwarn $bag->{$colour};
                # Dwarn $count;
                if ($bag->{$colour} < $count) {
                    next LINE
                }
            }
        }
        # if we got here, then the line was valid
        $sum += $game_id;
    }

    return $sum;
}

1;
