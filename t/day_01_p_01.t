use strict;
use warnings;

use FindBin qw/ $Bin /;
use lib "$Bin/../lib";

use Test::More;
use Solver;

my $solver = Solver->new(
    day => 1,
    puzzle => 1,
);

is $solver->run('1abc2'), 12;

is $solver->run('pqr3stu8vwx'), 38;

is $solver->run('a1b2c3d4e5f'), 15;

is $solver->run('treb7uchet'), 77;

is $solver->run('1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet'), 142;

done_testing;
