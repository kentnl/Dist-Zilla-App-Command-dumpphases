use strict;
use warnings;

package Dist::Zilla::dumpphases::Theme::basic::green;
BEGIN {
  $Dist::Zilla::dumpphases::Theme::basic::green::AUTHORITY = 'cpan:KENTNL';
}
{
  $Dist::Zilla::dumpphases::Theme::basic::green::VERSION = '0.3.3';
}

# ABSTRACT: A green color theme for C<dzil dumpphases>


use Moo;

with 'Dist::Zilla::dumpphases::Role::Theme::SimpleColor';


sub color { return 'green' }

1;

__END__

=pod

=encoding utf-8

=head1 NAME

Dist::Zilla::dumpphases::Theme::basic::green - A green color theme for C<dzil dumpphases>

=head1 VERSION

version 0.3.3

=head1 SYNOPSIS

    dzil dumpphases --color-theme=basic::green

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::dumpphases::Theme:::basic::green",
    "does":"Dist::Zilla::dumpphases::Role::Theme::SimpleColor",
    "inherits":"Moo::Object",
    "interface":"class"
}


=end MetaPOD::JSON

=for html <center><img src="http://kentfredric.github.io/Dist-Zilla-App-Command-dumpphases/media/theme_basic_green.png" alt="Screenshot" width="715" height="372"/></center>

=head1 METHODS

=head2 C<color>

See L<Dist::Zilla::dumpphases::Role::Theme::SimpleColor/color> for details.

This simply returns C<'green'>

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
