use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Dist::Zilla::dumpphases::Theme::basic::red;

our $VERSION = '1.000001';

# ABSTRACT: A red color theme for dzil dumpphases

# AUTHORITY

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::dumpphases::Theme:::basic::red",
    "does":"Dist::Zilla::dumpphases::Role::Theme::SimpleColor",
    "inherits":"Moo::Object",
    "interface":"class"
}

=end MetaPOD::JSON

=head1 SYNOPSIS

    dzil dumpphases --color-theme=basic::red

=for html <center><img src="http://kentfredric.github.io/Dist-Zilla-App-Command-dumpphases/media/theme_basic_red.png" alt="Screenshot" width="702" height="417"/></center>

=cut

use Moo qw( with );

with 'Dist::Zilla::dumpphases::Role::Theme::SimpleColor';

=method C<color>

See L<Dist::Zilla::dumpphases::Role::Theme::SimpleColor/color> for details.

This simply returns C<'red'>

=cut

sub color { return 'red' }

1;
