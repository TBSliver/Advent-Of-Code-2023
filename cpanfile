requires 'Moo';
requires 'MooX::Options';
requires 'namespace::clean';
requires 'Devel::Dwarn';
requires 'List::Util';

on 'test' => sub {
  requires 'Test::More';
};
