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

if ( not env_true('STERILIZE_ENV') ) {
  diag('STERILIZE_ENV unset or false, not sterilizing');
  exit 0;
}

if ( not env_true('TRAVIS') ) {
  diag('Is not running under travis!');
  exit 1;
}
if ( env_is( 'TRAVIS_PERL_VERSION', '5.8' ) or env_is( 'TRAVIS_PERL_VERSION', '5.10' ) ) {
  diag("\e[31m TREE STERILIZATION IMPOSSIBLE <= 5.10\e[0m");
  diag("\e[32m ... because prior to 5.11.*, dual-life installed to \e[33mprivlib\e[0m");
  diag("\e[32m ... because prior to 5.11.*, \e[33m\@INC\e[32m order was \e[33mprivlib,sitelib\e[0m");
  diag("\e[32m ... whereas after to 5.11.*, \e[33m\@INC\e[32m order is \e[33msitelib,privlib\e[0m");
  diag("\e[32m ... and now most dual-life things simply install to \e[33msitelib\e[0m");
  diag("\e[34m ( However, there are still a few naughty CPAN modules that install to \e[33mprivlib\e[34m )");
  diag(
    "\e[32m but the net effect of this is that installing \e[33mModule::Build 0.4007\e[32m which pulls \e[33mPerl::OSType\e[0m");
  diag("\e[32m and results in  \e[33mPerl::OSType\e[32m being later removed \e[0m");
  diag("\e[32m leaving behind a broken  \e[33mModule::Build 0.4007\e[32m\e[0m");
  diag("\e[34m Set \e[35m MAYBE_BREAK_MODULE_BUILD=1\e[34m if this is ok\e[0m");
  exit 0 unless env_true('MAYBE_BREAK_MODULE_BUILD');
  diag("\e[35m PROCEEDING\e[0m");
}
use Config;
for my $libdir ( grep { $_ =~ /site(lib|arch)exp$/ } keys %Config ) {
  safe_exec( 'find', $Config{$libdir}, '-type', 'f', '-delete' );
  safe_exec( 'find', $Config{$libdir}, '-depth', '-type', 'd', '-delete' );
}

