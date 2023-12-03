package Solver;

use Moo;

use MooX::Options protect_argv => 0;
use Module::Runtime qw/ use_module /;
use Path::Tiny;
use namespace::clean -except => [
  qw/ _options_data _options_config /
];

option day => (
  is => 'ro',
  required => 1,
  short => 'd',
  format => 'i',
  doc => 'The day to run the solver for',
);

option puzzle => (
  is => 'ro',
  required => 1,
  short => 'p',
  format => 'i',
  doc => 'Which puzzle to run the solver for',
);

option input => (
  is => 'ro',
  short => 'i',
  format => 's',
  doc => 'Input file',
);

has day_solver => (
  is => 'lazy',
  clearer => 1,
  builder => sub {
    my $self = shift;
    my $module_name
      = sprintf( 'Solver::Day%02d::Puzzle%02d', $self->day, $self->puzzle );
    return use_module( $module_name )->new();
  },
);

sub new_with_actions {
  my $class = shift;

  my $self = $class->new_with_options(@_);

  my $file = path($self->input)->slurp_utf8;

  print $self->run( $file ) . "\n";
}

sub run {
  my ( $self, @args ) = @_;

  my $result = $self->day_solver->run( @args );

  $self->reset;

  return $result;
}

sub reset {
  my $self = shift;

  $self->clear_day_solver;
}

1;
