#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

sub diag { print STDERR @_; print STDERR "\n" }
sub env_exists { return exists $ENV{ $_[0] } }
sub env_true   { return ( env_exists( $_[0] ) and $ENV{ $_[0] } ) }
sub env_is     { return ( env_exists( $_[0] ) and $ENV{ $_[0] } eq $_[1] ) }

sub safe_exec_nonfatal {
  my ( $command, @params ) = @_;
  diag("running $command @params");
  my $exit = system( $command, @params );
  if ( $exit != 0 ) {
    my $low  = $exit & 0b11111111;
    my $high = $exit >> 8;
    warn "$command failed: $? $! and exit = $high , flags = $low";
    if ( $high != 0 ) {
      return $high;
    }
    else {
      return 1;
    }

  }
  return 0;
}

sub safe_exec {
  my ( $command, @params ) = @_;
  my $exit_code = safe_exec_nonfatal( $command, @params );
  if ( $exit_code != 0 ) {
    exit $exit_code;
  }
  return 1;
}

if ( not env_exists('TRAVIS') ) {
  diag('Is not running under travis!');
  exit 1;
}

if ( env_is( 'TRAVIS_BRANCH', 'master' ) ) {
  my $xtest = safe_exec_nonfatal( 'dzil', 'xtest' );
  my $test  = safe_exec_nonfatal( 'dzil', 'test' );
  if ( $test != 0 ) {
    exit $test;
  }
  if ( $xtest != 0 ) {
    exit $xtest;
  }
  exit 0;
}
else {
  my @paths = './t';

  if ( env_true('AUTHOR_TESTING') or env_true('RELEASE_TESTING') ) {
    push @paths, './xt';
  }
  safe_exec( 'prove', '--blib', '--shuffle', '--color', '--recurse', '--timer', '--jobs', 30, @paths );
}
