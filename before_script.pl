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

