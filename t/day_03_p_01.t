use strict;
use warnings;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

use Test::More;
use Solver;

my $solver = Solver->new(
    day => 3,
    puzzle => 1,
);

is $solver->run('467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..'), 4361;

done_testing;
