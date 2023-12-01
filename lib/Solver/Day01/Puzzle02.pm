package Solver::Day01::Puzzle02;

use Moo;
use Devel::Dwarn;

extends 'Solver::Day01::Puzzle01';

my %nums = (
    one   => 1,
    two   => 2,
    three => 3,
    four  => 4,
    five  => 5,
    six   => 6,
    seven => 7,
    eight => 8,
    nine  => 9,
);

around run => sub {
    my ($orig, $self, $string) = @_;

    # First and last match is all that matters
    my $regex = qr/(one|two|three|four|five|six|seven|eight|nine)/;

    my @data = split("\n", $string);

    my $next = "";
    for my $line (@data) {

        # block scoped due to reusing $1
        # {
        #     # replace first occurance
        #     $line =~ /^.*?$regex.*$/;
        #     if (defined $1) {
        #         substr($line, $-[1], $+[1] - $-[1], $nums{$1});
        #     }
        # }
        #
        # {
        #     # replace last occurance
        #     $line =~ /^.*$regex.*?$/;
        #     if (defined $1) {
        #         substr($line, $-[1], $+[1] - $-[1], $nums{$1});
        #     }
        # }

        # not smart enough, need more...
        # while (1) {
        #     my ($match) = $line =~ /^.*?$regex.*$/;
        #     if (defined $match) {
        #         substr($line, $-[1], $+[1] - $-[1], $nums{$match});
        #     } else {
        #         last;
        #     }
        # }

        # need to use zero width look ahead, as eighthree counts as 83...
        while ($line =~ /(?=$regex)/g) {
            substr($line, $-[1], 1, $nums{$1});
        }

        $next .= $line . "\n";
    }

    return $self->$orig($next);
};

1;
