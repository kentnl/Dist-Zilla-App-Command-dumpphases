use strict;
use warnings;

package Dist::Zilla::dumpphases::Theme::basic::plain;
BEGIN {
  $Dist::Zilla::dumpphases::Theme::basic::plain::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::dumpphases::Theme::basic::plain::VERSION = '0.5.1';
}

# ABSTRACT: A plain-text theme for C<dzil dumpphases>



use Moo;

with 'Dist::Zilla::dumpphases::Role::Theme';


sub print_section_header {
  my ( $self, $label, $value ) = @_;
  return printf "\n%s%s\n", $label, $value;
}


sub print_section_prelude {
  my ( $self, $label, $value ) = @_;
  return printf "%s%s\n", ' - ' . $label, $value;
}


sub print_star_assoc {
  my ( $self, $name, $value ) = @_;
  return printf "%s%s%s\n", ' * ', $name, ' => ' . $value;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::dumpphases::Theme::basic::plain - A plain-text theme for C<dzil dumpphases>

=head1 VERSION

version 0.5.1

=head1 SYNOPSIS

    dzil dumpphases --color-theme=basic::plain

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::dumpphases::Theme:::basic::plain",
    "does":"Dist::Zilla::dumpphases::Role::Theme",
    "inherits":"Moo::Object",
    "interface":"class"
}


=end MetaPOD::JSON

=for html <center><img src="http://kentfredric.github.io/Dist-Zilla-App-Command-dumpphases/media/theme_basic_plain.png" alt="Screenshot" width="677" height="412"/></center>

=head1 METHODS

=head2 C<print_section_header>

See L<Dist::Zilla::dumpphases::Role::Theme/print_section_header>.

This satisfies that, printing C<$label> and C<$value>,uncolored, as

    \n
    $label$value\n

=head2 C<print_section_prelude>

See L<Dist::Zilla::dumpphases::Role::Theme/print_section_prelude>.

This satisfies that, printing C<$label> and C<$value> uncolored, as:

     - $label$value\n

=head2 C<print_star_assoc>

See L<Dist::Zilla::dumpphases::Role::Theme/print_star_assoc>.

This satisfies that, printing C<$label> and C<$value> uncolored, as:

     * $label => $value

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
