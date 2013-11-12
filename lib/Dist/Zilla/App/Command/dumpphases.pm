use strict;
use warnings;

package Dist::Zilla::App::Command::dumpphases;
BEGIN {
  $Dist::Zilla::App::Command::dumpphases::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::App::Command::dumpphases::VERSION = '0.5.0';
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

  my $seen_plugins = {};

  require Dist::Zilla::Util::RoleDB;

  for my $phase ( Dist::Zilla::Util::RoleDB->new()->phases ) {
    my ( $label );
    $label = $phase->name;
    $label =~ s/\A-//msx;
    $label =~ s/([[:lower:]])([[:upper:]])/$1 $2/gmsx;

    my @plugins;
    push @plugins, $zilla->plugins_with($phase->name)->flatten;
    next unless @plugins;

    $theme->print_section_header( 'Phase: ', $label );
    $theme->print_section_prelude( 'description: ', $phase->description );
    $theme->print_section_prelude( 'role: ', $phase->name );
    $theme->print_section_prelude( 'phase_method: ', $phase->phase_method );

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

=encoding UTF-8

=head1 NAME

Dist::Zilla::App::Command::dumpphases - Dump a textual representation of each phase's parts.

=head1 VERSION

version 0.5.0

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
