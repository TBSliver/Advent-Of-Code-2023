use strict;
use warnings;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

use Test::More;
use Solver;

my $solver = Solver->new(
    day => 1,
    puzzle => 2,
);

is $solver->run('two1nine'), 29;
is $solver->run('eightwothree'), 83;
is $solver->run('abcone2threexyz'), 13;
is $solver->run('xtwone3four'), 24;
is $solver->run('4nineeightseven2'), 42;
is $solver->run('zoneight234'), 14;
is $solver->run('7pqrstsixteen'), 76;

is $solver->run('two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen'), 281;

# extra not in the example that need to pass
is $solver->run('eighthree'), 83;

done_testing;
