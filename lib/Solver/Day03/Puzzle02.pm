package Solver::Day03::Puzzle02;

use Moo;
use Devel::Dwarn;
use List::Util qw(min);

use constant DOT => 0;
use constant DIGIT => -1;
use constant GEAR => 1;

has lines => (
  is      => "rwp",
  default => sub {[]}
);

has num_lines => (
  is      => 'lazy',
  builder => sub {
    my $self = shift;
    return scalar($self->lines->@*);
  }
);

has line_length => (
  is      => 'lazy',
  builder => sub {
    my $self = shift;
    return length($self->lines->[0]);
  }
);

sub get_char {
  my ($self, $line_idx, $char_idx) = @_;
  return substr($self->lines->[$line_idx], $char_idx, 1);
}

sub check_char {
  my ($self, $line_idx, $char_idx) = @_;
  my $char = $self->get_char($line_idx, $char_idx);
  if ($char =~ /\d/) {
    return DIGIT
  }
  elsif ($char eq "*") {
    return GEAR
  }
  return DOT
}

sub get_number {
  my ($self, $line_idx, $char_idx) = @_;
  # find idx of start of number
  my $start_idx = $char_idx;
  while($self->check_char($line_idx, $start_idx) == DIGIT) {
    $start_idx--;
    last if ($start_idx < 0);
  }
  $start_idx++;

  my $end_idx = $char_idx;
  while($self->check_char($line_idx, $end_idx) == DIGIT) {
    $end_idx++;
    last if ($end_idx >= $self->line_length);
  }
  return substr($self->lines->[$line_idx], $start_idx, $end_idx - $start_idx);
}

sub run {
  my ($self, $schematic) = @_;

  $self->_set_lines([ split(/[\r\n]+/, $schematic) ]);

  my $total = 0;

  for my $line_idx (0 .. ($self->num_lines - 1)) {
    for my $char_idx (0 .. ($self->line_length - 1)) {
      my $char_check = $self->check_char($line_idx, $char_idx);
      if ($char_check == GEAR) {
        Dwarn "Gear Found";

        my ($ul_check, $uc_check, $ur_check) = (DOT, DOT, DOT);
        my ($cl_check, $cr_check) = (DOT, DOT);
        my ($ll_check, $lc_check, $lr_check) = (DOT, DOT, DOT);

        # check line above
        if ($line_idx > 0) {
          $ul_check = $char_idx > 0 ? $self->check_char($line_idx - 1, $char_idx - 1) : DOT;
          $uc_check = $self->check_char($line_idx - 1, $char_idx);
          $ur_check = $char_idx < $self->line_length - 1 ? $self->check_char($line_idx - 1, $char_idx + 1) : DOT;
        }
        # check current line
        $cl_check = $char_idx > 0 ? $self->check_char($line_idx, $char_idx - 1) : DOT;
        $cr_check = $char_idx < $self->line_length - 1 ? $self->check_char($line_idx, $char_idx + 1) : DOT;
        # check line below
        if ($line_idx < $self->num_lines - 1) {
          $ll_check = $char_idx > 0 ? $self->check_char($line_idx + 1, $char_idx - 1) : DOT;
          $lc_check = $self->check_char($line_idx + 1, $char_idx);
          $lr_check = $char_idx < $self->line_length - 1 ? $self->check_char($line_idx + 1, $char_idx + 1) : DOT;
        }
        # are any of them digits?
        if (min($ul_check, $uc_check, $ur_check, $cl_check, $cr_check, $ll_check, $lc_check, $lr_check)) {
          my $num_neighbours = 0;
          my @neighbour_nums;
          # check above. if uc is a digit, then only 1 number can be adjacent above
          if ($uc_check == DIGIT) {
            $num_neighbours += 1;
            push @neighbour_nums, $self->get_number($line_idx - 1, $char_idx);
          } else {
            if ($ul_check == DIGIT) {
              $num_neighbours += 1;
              push @neighbour_nums, $self->get_number($line_idx - 1, $char_idx - 1);
            }
            if ($ur_check == DIGIT) {
              $num_neighbours += 1;
              push @neighbour_nums, $self->get_number($line_idx - 1, $char_idx + 1);
            }
          }
          # same for below
          if ($lc_check == DIGIT) {
            $num_neighbours += 1;
            push @neighbour_nums, $self->get_number($line_idx + 1, $char_idx);
          } else {
            if ($ll_check == DIGIT) {
              $num_neighbours += 1;
              push @neighbour_nums, $self->get_number($line_idx + 1, $char_idx - 1);
            }
            if ($lr_check == DIGIT) {
              $num_neighbours += 1;
              push @neighbour_nums, $self->get_number($line_idx + 1, $char_idx + 1);
            }
          }
          if ($cl_check == DIGIT) {
            $num_neighbours += 1;
            push @neighbour_nums, $self->get_number($line_idx, $char_idx - 1);
          }
          if ($cr_check == DIGIT) {
            $num_neighbours += 1;
            push @neighbour_nums, $self->get_number($line_idx, $char_idx + 1);
          }

          if ($num_neighbours == 2) {
            Dwarn \@neighbour_nums;
            $total += $neighbour_nums[0] * $neighbour_nums[1];
          }
        }
        # otherwise we dont care, goodbye
      }
    }
  }

  return $total;
}

1;
