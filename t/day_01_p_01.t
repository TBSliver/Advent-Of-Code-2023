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

is $solver->run, 1;

done_testing;
