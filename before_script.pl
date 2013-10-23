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
  my $result = safe_exec_nonfatal( $command, @params );
  exit $result if $result != 0;
}

if ( env_is( 'TRAVIS_BRANCH', 'master' ) ) {
  diag("before_script skipped, TRAVIS_BRANCH=master");
  exit 0;
}
else {
  if ( -e './Build.PL' ) {
    safe_exec( $^X, './Build.PL' );
    safe_exec("./Build");
    exit 0;
  }
  if ( -e './Makefile.PL' ) {
    safe_exec( $^X, './Makefile.PL' );
    safe_exec("make");
    exit 0;
  }
}

