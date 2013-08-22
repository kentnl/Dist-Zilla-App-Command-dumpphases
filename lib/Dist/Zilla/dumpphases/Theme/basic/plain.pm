use strict;
use warnings;

package Dist::Zilla::dumpphases::Theme::basic::plain;

# ABSTRACT: A plain-text theme for C<dzil dumpphases>

use Moo;

with 'Dist::Zilla::dumpphases::Role::Theme';

=method C<print_section_header>

See L<Dist::Zilla::dumpphases::Role::Theme/print_section_header>.

This satisfies that, printing C<$label> and C<$value>,uncolored, as

    \n
    $label$value\n

=cut

sub print_section_header {
  my ( $self, $label, $value ) = @_;
  return printf "\n%s%s\n", $label, $value;
}

=method C<print_section_prelude>

See L<Dist::Zilla::dumpphases::Role::Theme/print_section_prelude>.

This satisfies that, printing C<$label> and C<$value> uncolored, as:

     - $label$value\n

=cut

sub print_section_prelude {
  my ( $self, $label, $value ) = @_;
  return printf "%s%s\n", ' - ' . $label, $value;
}

=method C<print_star_assoc>

See L<Dist::Zilla::dumpphases::Role::Theme/print_star_assoc>.

This satisfies that, printing C<$label> and C<$value> uncolored, as:

     * $label => $value

=cut

sub print_star_assoc {
  my ( $self, $name, $value ) = @_;
  return printf "%s%s%s\n", ' * ', $name, ' => ' . $value;
}

1;
