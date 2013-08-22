use strict;
use warnings;

package Dist::Zilla::dumpphases::Theme::basic::red;
BEGIN {
  $Dist::Zilla::dumpphases::Theme::basic::red::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::dumpphases::Theme::basic::red::VERSION = '0.2.1';
}

# ABSTRACT: A red color theme for C<dzil dumpphases>


use Moo;

with 'Dist::Zilla::dumpphases::Role::Theme::SimpleColor';


sub color { return 'red' }

1;

__END__

=pod

=encoding utf-8

=head1 NAME

Dist::Zilla::dumpphases::Theme::basic::red - A red color theme for C<dzil dumpphases>

=head1 VERSION

version 0.2.1

=head1 SYNOPSIS

    dzil dumpphases --color-theme=basic::red

=head1 METHODS

=head2 C<color>

See L<Dist::Zilla::dumpphases::Role::Theme::SimpleColor/color> for details.

This simply returns C<'red'>

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
