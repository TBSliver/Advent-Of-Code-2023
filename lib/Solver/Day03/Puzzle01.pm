package Solver::Day03::Puzzle01;

use Moo;
use Devel::Dwarn;
use List::Util qw(max);

use constant DOT => 0;
use constant DIGIT => -1;
use constant SYMBOL => 1;

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
  elsif ($char eq ".") {
    return DOT
  }
  return SYMBOL
}

sub run {
  my ($self, $schematic) = @_;

  $self->_set_lines([ split(/[\r\n]+/, $schematic) ]);

  my $sum = 0;

  for my $line_idx (0 .. ($self->num_lines - 1)) {
    my $cur_number = "";
    my $symbol_flag = 0;
    for my $char_idx (0 .. ($self->line_length - 1)) {
      my $char_check = $self->check_char($line_idx, $char_idx);
      if ($char_check == DIGIT) {
        # append it to current number
        $cur_number .= $self->get_char($line_idx, $char_idx);
        # check line above if we have one
        my ($upper, $center, $lower) = (0, 0, 0);
        if ($line_idx > 0) {
          my $l_check = $char_idx > 0 ? $self->check_char($line_idx - 1, $char_idx - 1) : DOT;
          my $c_check = $self->check_char($line_idx - 1, $char_idx);
          my $r_check = $char_idx < $self->line_length - 1 ? $self->check_char($line_idx - 1, $char_idx + 1) : DOT;
          $upper = max($l_check, $c_check, $r_check);
        }
        {
          # check current line
          my $l_check = $char_idx > 0 ? $self->check_char($line_idx, $char_idx - 1) : DOT;
          my $r_check = $char_idx < $self->line_length - 1 ? $self->check_char($line_idx, $char_idx + 1) : DOT;
          $center = max($l_check, $r_check);
        }
        # check line below if there is one
        if ($line_idx < $self->num_lines - 1) {
          my $l_check = $char_idx > 0 ? $self->check_char($line_idx + 1, $char_idx - 1) : DOT;
          my $c_check = $self->check_char($line_idx + 1, $char_idx);
          my $r_check = $char_idx < $self->line_length - 1 ? $self->check_char($line_idx + 1, $char_idx + 1) : DOT;
          $lower = max($l_check, $c_check, $r_check);
        }
        if (max($upper, $center, $lower) == SYMBOL) {
          $symbol_flag++;
        }
      }
      {
        # should we add to sum? if next char is not a number, and we've triggered a symbol flag, add it!
        my $next_char = $char_idx < $self->line_length - 1 ? $self->check_char($line_idx, $char_idx + 1) : DOT;
        if ($next_char != DIGIT) {
          if ($symbol_flag > 0 && $cur_number ne "") {
            $sum += $cur_number;
            # Dwarn "Got Match added: $cur_number [$sum]";
          }
          $cur_number = "";
          $symbol_flag = 0;
        }
      }
    }
  }
  return $sum;
}

1;
