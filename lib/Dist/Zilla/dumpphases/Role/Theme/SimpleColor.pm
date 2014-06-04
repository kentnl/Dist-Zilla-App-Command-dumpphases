
use strict;
use warnings;

package Dist::Zilla::dumpphases::Role::Theme::SimpleColor;

our $VERSION = '1.000000';

# ABSTRACT: A role for themes that are simple single-color themes with variations of bold/uncolored.

# AUTHORITY

use Role::Tiny;

=head1 SYNOPSIS

    package Dist::Zilla::dumpphases::Theme::foo;

    use Moo;
    with 'Dist::Zilla::dumpphases::Role::Theme::SimpleColor';
    sub color { 'magenta' };

    ...

    dzil dumpphases --color-theme=foo

=cut

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::dumpphases::Role::Theme::SimpleColor",
    "does":"Dist::Zilla::dumpphases::Role::Theme",
    "interface":"role"
}

=end MetaPOD::JSON

with 'Dist::Zilla::dumpphases::Role::Theme';

=requires C<color>

You must define a method called C<color> that returns a string (or list of strings ) that C<Term::ANSIColor> recognizes.

=cut

requires 'color';

## no critic ( RequireArgUnpacking )
sub _colored {
  require Term::ANSIColor;
  goto \&Term::ANSIColor::colored;
}

sub _color_label_label {
  my $self = shift;
  return _colored( [ $self->color ], @_ );
}

sub _color_label_value {
  shift;
  return _colored( ['bold'], @_ );
}

sub _color_attribute_label {
  my $self = shift;
  return _colored( [ $self->color, 'bold' ], @_ );
}

sub _color_attribute_value {
  my $self = shift;
  return _colored( [ $self->color ], @_ );
}

sub _color_plugin_name {
  shift;
  return @_;
}

sub _color_plugin_package {
  my $self = shift;
  return _colored( [ $self->color ], @_ );
}

sub _color_plugin_star {
  my $self = shift;
  return _colored( [ $self->color ], @_ );
}

=method C<print_section_header>

See L<Dist::Zilla::dumpphases::Role::Theme/print_section_header>.

This satisfies that, printing label colored, and the value uncolored.

=cut

sub print_section_header {
  my ( $self, $label, $comment ) = @_;
  return printf "\n%s%s\n", $self->_color_label_label($label), $self->_color_label_value($comment);
}

=method C<print_section_prelude>

See L<Dist::Zilla::dumpphases::Role::Theme/print_section_prelude>.

This satisfies that, printing label bold and colored, and the value simply colored.

=cut

sub print_section_prelude {
  my ( $self, $label, $value ) = @_;
  return printf "%s%s\n", $self->_color_attribute_label( ' - ' . $label ), $self->_color_attribute_value($value);
}

=method C<print_star_assoc>

See L<Dist::Zilla::dumpphases::Role::Theme/print_star_assoc>.

This satisfies that, printing label uncolored, and the value simply colored.

=cut

sub print_star_assoc {
  my ( $self, $name, $value ) = @_;
  return printf "%s%s%s\n",
    $self->_color_plugin_star(' * '),
    $self->_color_plugin_name($name),
    $self->_color_plugin_package( ' => ' . $value );
}

1;
