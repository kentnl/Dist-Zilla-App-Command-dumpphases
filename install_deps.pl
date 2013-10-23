#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

sub diag { print STDERR @_; print STDERR "\n" }
sub env_exists { return exists $ENV{ $_[0] } }
sub env_true   { return env_exists( $_[0] ) and $ENV{ $_[0] } }
sub env_is     { return env_exists( $_[0] ) and $ENV{ $_[0] } eq $_[1] }

sub safe_exec {
  my ( $command, @params ) = @_;
  diag("running $command @params");
  my $exit = system( $command, @params );
  if ( $exit != 0 ) {
    my $low  = $exit & 0b11111111;
    my $high = $exit >> 8;
    warn "$command failed: $? $! and exit = $high , flags = $low";
    if ( $high != 0 ) {
      exit $high;
    }
    else {
      exit 1;
    }
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
if ( env_is( 'TRAVIS_BRANCH', 'master' ) ) {
  safe_exec( 'cpanm', @params, 'Dist::Zilla', 'Capture::Tiny' );
  require Capture::Tiny;
  my $stdout = Capture::Tiny::capture_stdout(
    sub {
      safe_exec( 'dzil', 'authordeps', '--missing' );
    }
  );
  safe_exec( 'cpanm', @params, split /\n/, $stdout );
  $stdout = Capture::Tiny::capture_stdout(
    sub {
      safe_exec( 'dzil', 'listdeps', '--missing' );
    }
  );
  safe_exec( 'cpanm', @params, split /\n/, $stdout );
}
else {
  safe_exec( 'cpanm', @params, '--installdeps', '.' );
  if ( env_true('AUTHOR_TESTING') or env_true('RELEASE_TESTING') ) {
    require CPAN::Meta;
    my $meta    = CPAN::Meta->load_file('META.json');
    my $prereqs = $meta->effective_prereqs;
    my $reqs    = $prereqs->requirements_for( 'develop', 'requires' );
    for my $module ( sort $reqs->required_modules ) {
      safe_exec( 'cpanm', @params, $module . '~' . $reqs->requirements_for_module($module) );
    }
  }
}

exit 0;
