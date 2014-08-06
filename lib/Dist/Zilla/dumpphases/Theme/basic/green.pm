use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Dist::Zilla::dumpphases::Theme::basic::green;

our $VERSION = '1.000004';

# ABSTRACT: A green color theme for dzil dumpphases

# AUTHORITY

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::dumpphases::Theme:::basic::green",
    "does":"Dist::Zilla::dumpphases::Role::Theme::SimpleColor",
    "inherits":"Moo::Object",
    "interface":"class"
}

=end MetaPOD::JSON

=head1 SYNOPSIS

    dzil dumpphases --color-theme=basic::green

=for html <center><img src="http://kentnl.github.io/Dist-Zilla-App-Command-dumpphases/media/theme_basic_green.png" alt="Screenshot" width="715" height="372"/></center>

=cut

use Moo qw( with );

with 'Dist::Zilla::dumpphases::Role::Theme::SimpleColor';

=method C<color>

See L<Dist::Zilla::dumpphases::Role::Theme::SimpleColor/color> for details.

This simply returns C<'green'>

=cut

sub color { return 'green' }

1;
