#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Cwd qw(cwd);

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

sub cpanm {
  my (@params) = @_;
  my $exit_code = safe_exec_nonfatal( 'cpanm', @params );
  if ( $exit_code != 0 ) {
    safe_exec( 'tail', '-n', '200', '/home/travis/.cpanm/build.log' );
    exit $exit_code;
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
  cpanm( @params, 'Dist::Zilla', 'Capture::Tiny', 'Pod::Weaver' );
  cpanm( @params, '--dev',       'Dist::Zilla',   'Pod::Weaver' );
  safe_exec( 'git', 'config', '--global', 'user.email', 'kentfredric+travisci@gmail.com' );
  safe_exec( 'git', 'config', '--global', 'user.name',  'Travis CI ( On behalf of Kent Fredric )' );
  mkdir '/tmp';
  my $cwd = cwd();
  chdir '/tmp';
  safe_exec( 'git', 'clone', 'https://github.com/kentfredric/cpan-fixes.git' );
  chdir '/tmp/cpan-fixes';
  cpanm( @params, './Dist-Zilla-Plugin-Git-2.017.tar.gz' );

  #cpanm( @params, './Dist-Zilla-Plugin-Prepender-1.132960.tar.gz' );
  chdir $cwd;
  require Capture::Tiny;
  my $stdout = Capture::Tiny::capture_stdout(
    sub {
      safe_exec( 'dzil', 'authordeps', '--missing' );
    }
  );
  if ( $stdout !~ /^\s*$/msx ) {
    cpanm( @params, split /\n/, $stdout );
  }
  $stdout = Capture::Tiny::capture_stdout(
    sub {
      safe_exec( 'dzil', 'listdeps', '--missing' );
    }
  );
  if ( $stdout !~ /^\s*$/msx ) {
    cpanm( @params, split /\n/, $stdout );
  }
}
else {
  cpanm( @params, '--installdeps', '.' );
  if ( env_true('AUTHOR_TESTING') or env_true('RELEASE_TESTING') ) {
    require CPAN::Meta;
    my $meta    = CPAN::Meta->load_file('META.json');
    my $prereqs = $meta->effective_prereqs;
    my $reqs    = $prereqs->requirements_for( 'develop', 'requires' );

    cpanm( @params, map { $_ . '~' . $reqs->requirements_for_module($_) } $reqs->required_modules );

  }
}

exit 0;
