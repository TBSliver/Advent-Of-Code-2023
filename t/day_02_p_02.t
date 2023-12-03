use strict;
use warnings;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

use Test::More;
use Solver;

my $solver = Solver->new(
    day => 2,
    puzzle => 2,
);

is $solver->run('Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green'), 48;
is $solver->run('Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue'), 12;
is $solver->run('Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red'), 1560;
is $solver->run('Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red'), 630;
is $solver->run('Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green'), 36;

is $solver->run('Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green'), 2286;

done_testing;
