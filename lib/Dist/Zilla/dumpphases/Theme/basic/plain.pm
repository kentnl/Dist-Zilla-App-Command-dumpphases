use strict;
use warnings;

package Dist::Zilla::dumpphases::Theme::basic::plain;
BEGIN {
  $Dist::Zilla::dumpphases::Theme::basic::plain::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::dumpphases::Theme::basic::plain::VERSION = '0.2.1';
}

use Moo;

with 'Dist::Zilla::dumpphases::Role::Theme';

## no critic ( RequireArgUnpacking )
sub print_section_header {
  my ( $self, $label, $comment ) = @_;
  return printf "\n%s%s\n", $label, $comment;
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

=encoding utf-8

=head1 NAME

Dist::Zilla::dumpphases::Theme::basic::plain

=head1 VERSION

version 0.2.1

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
