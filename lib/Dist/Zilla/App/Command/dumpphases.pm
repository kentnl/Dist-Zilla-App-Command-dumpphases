use strict;
use warnings;

package Dist::Zilla::App::Command::dumpphases;
BEGIN {
  $Dist::Zilla::App::Command::dumpphases::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::App::Command::dumpphases::VERSION = '0.3.1';
}

# ABSTRACT: Dump a textual representation of each phase's parts.




use Dist::Zilla::App -command;
use Moose::Autobox;
use Try::Tiny;
use Scalar::Util qw( blessed );

## no critic ( ProhibitAmbiguousNames)
sub abstract { return 'Dump a textual representation of each phase\'s parts' }
## use critic

sub opt_spec {
  return [ 'color-theme=s', 'color theme to use, ( eg: basic::blue )' ];
}

sub _phases {
  my (@phases) = (
    [ 'Version',           ['-VersionProvider'], 'Provide a version for the distribution' ],
    [ 'MetaData',          ['-MetaProvider'],    'Specify MetaData for the distribution' ],
    [ 'ExecFiles',         ['-ExecFiles'],       undef ],
    [ 'ShareDir',          ['-ShareDir'],        undef ],
    [ 'Before Build',      ['-BeforeBuild'],     undef ],
    [ 'Gather Files',      ['-FileGatherer'],    'Add files to your distribution somehow' ],
    [ 'Prune Files',       ['-FilePruner'],      'Remove fils from your distribution' ],
    [ 'Munge Files',       ['-FileMunger'],      'Modify files in the distribution in-memory' ],
    [ 'Register Preqreqs', ['-PrereqSource'],    'Advertise prerequisites to the distribution metadata' ],
    [ 'Install Tool',      ['-InstallTool'],     'Add a tool ( or tool-based files) for end users to install your dist with' ],
    [ 'After Build',       ['-AfterBuild'],      undef ],
    [ 'Before Archive',    ['-BeforeArchive'],   undef ],
    [ 'Releaser',          ['-Releaser'],        'Broadcast a copy of a built distribution to somewhere' ],
    [ 'Before Release',    ['-BeforeRelease'],   undef ],
    [ 'After Release',     ['-AfterRelease'],    undef ],
    [ 'Test Runner',       ['-TestRunner'],      undef ],
    [ 'Build Runner',      ['-BuildRunner'],     undef ],
    [ 'BeforeMint',        ['-BeforeMint'],      undef ],
    [ 'AfterMint',         ['-AfterMint'],       undef ],
  );
  return \@phases;
}

sub _get_color_theme {
  my ( $self, $opt, $default ) = @_;
  return $default unless $opt->color_theme;
  return $opt->color_theme;
}

sub _get_theme_instance {
  my ( $self, $theme ) = @_;
  require Module::Runtime;
  my $theme_module = Module::Runtime::compose_module_name( 'Dist::Zilla::dumpphases::Theme', $theme );
  Module::Runtime::require_module($theme_module);
  return $theme_module->new();
}

sub execute {
  my ( $self, $opt, $args ) = @_;
  my $zilla = $self->zilla;

  my $theme = $self->_get_theme_instance( $self->_get_color_theme( $opt, 'basic::blue' ) );

  my $phases = $self->_phases;

  my $seen_plugins = {};

  for my $phase ( @{$phases} ) {
    my ( $label, $roles, $description ) = @{$phase};
    my @plugins;
    push @plugins, $zilla->plugins_with($_)->flatten for @{$roles};
    next unless @plugins;

    $theme->print_section_header( 'Phase: ', $label );

    if ($description) {
      $theme->print_section_prelude( 'description: ', $description );
    }
    for my $role ( @{$roles} ) {
      $theme->print_section_prelude( 'role: ', $role );
    }

    for my $plugin (@plugins) {
      $seen_plugins->{ $plugin->plugin_name } = 1;
      $theme->print_star_assoc( $plugin->plugin_name, blessed($plugin) );
    }
  }
  my @unrecognised;
  for my $plugin ( @{ $zilla->plugins } ) {
    next if exists $seen_plugins->{ $plugin->plugin_name };
    push @unrecognised, $plugin;
  }
  if (@unrecognised) {
    $theme->print_section_header( 'Unrecognised: ', 'Phase not known' );
    $theme->print_section_prelude( 'description: ', 'These plugins exist but were not in any predefined phase to scan for' );
    for my $plugin (@unrecognised) {
      $theme->print_star_assoc( $plugin->plugin_name, blessed($plugin) );
    }
  }
  return 0;
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

Dist::Zilla::App::Command::dumpphases - Dump a textual representation of each phase's parts.

=head1 VERSION

version 0.3.1

=head1 SYNOPSIS

  cd $PROJECT;
  dzil dumpphases

  dzil dumpphases --color-theme=basic::plain # plain text
  dzil dumpphases --color-theme=basic::green # green text

If you are using an HTML-enabled POD viewer, you should see a screenshot of this in action:

( Everyone else can visit L<http://kentfredric.github.io/Dist-Zilla-App-Command-dumpphases/media/example_01.png> )

=for html <center><img src="http://kentfredric.github.io/Dist-Zilla-App-Command-dumpphases/media/example_01.png" alt="Screenshot" width="721" height="1007"/></center>

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::App::Command::dumpphases",
    "inherits":"Dist::Zilla::App::Command",
    "interface":"class"
}


=end MetaPOD::JSON

=head1 DESCRIPTION

Working out what Plugins will execute in which order during which phase can be a
little confusing sometimes.

This Command exists primarily to make developing Plugin Bundles and debugging
dist.ini a bit easier, especially for newbies who may not fully understand
Bundles yet.

If you want to turn colors off, use L<< C<Term::ANSIcolor>'s environment variable|Term::ANSIColor >>
C<ANSI_COLORS_DISABLED>. E.g.,

C<ANSI_COLORS_DISABLED=1 dzil dumpphases>

Alternatively, since 0.3.0 you can specify a color-free theme:

    dzil dumpphases --color-theme=basic::plain

=head1 AUTHORS

=over 4

=item *

Kent Fredric <kentnl@cpan.org>

=item *

Alan Young <harleypig@gmail.com>

=item *

Oliver Mengué <dolmen@cpan.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Kent Fredric <kentnl@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
