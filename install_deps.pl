#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

sub diag { print STDERR @_; print STDERR "\n" }
sub env_exists { return exists $ENV{ $_[0] } }
sub env_true { return env_exists( $_[0] ) and $ENV{ $_[0] } }

sub safe_exec {
  my ( $command, @params ) = @_;
  diag("running $command @params");
  my $exit = system( $command, @params );
  if ( $exit != 0 ) {
    warn "$command failed: $? $!";
    exit $exit;
  }
  return 1;
}

if ( not env_exists('TRAVIS') ) {
  diag('Is not running under travis!');
  exit 1;
}

my (@params) = qw[ --quiet --notest --mirror http://cpan.metacpan.org/ --no-man-pages ];
if ( env_true('DEVELOPER_DEPS') ) {
  push @params, '--dev';
}
safe_exec( 'cpanm', @params, '--installdeps', '.' );
if ( env_true('AUTHOR_TESTING') or env_true('RELEASE_TESTING') ) {
  safe_exec( 'cpanm', @params, '--with-develop', '--installdeps', '.' );
}

exit 0;
