use strict;
use warnings;

package Dist::Zilla::dumpphases::Role::Theme;
BEGIN {
  $Dist::Zilla::dumpphases::Role::Theme::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::dumpphases::Role::Theme::VERSION = '0.3.0';
}

use Role::Tiny;

requires 'print_star_assoc';
requires 'print_section_prelude';
requires 'print_section_header';

1;

__END__

=pod

=encoding utf-8

=head1 NAME

Dist::Zilla::dumpphases::Role::Theme

=head1 VERSION

version 0.3.0

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
