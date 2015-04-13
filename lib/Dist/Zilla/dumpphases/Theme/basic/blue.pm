use 5.006;
use strict;
use warnings;

package Dist::Zilla::dumpphases::Theme::basic::blue;

our $VERSION = '1.000008';

# ABSTRACT: A blue color theme for dzil dumpphases

# AUTHORITY

=begin MetaPOD::JSON v1.1.0

{
    "namespace":"Dist::Zilla::dumpphases::Theme:::basic::blue",
    "does":"Dist::Zilla::dumpphases::Role::Theme::SimpleColor",
    "inherits":"Moo::Object",
    "interface":"class"
}

=end MetaPOD::JSON

=cut

use Moo qw( with );

with 'Dist::Zilla::dumpphases::Role::Theme::SimpleColor';

=method C<color>

See L<Dist::Zilla::dumpphases::Role::Theme::SimpleColor/color> for details.

This simply returns C<'blue'>

=cut

sub color { return 'blue' }

1;

=head1 SYNOPSIS

    dzil dumpphases --color-theme=basic::blue

=begin html

<center>
  <img src="http://kentnl.github.io/screenshots/Dist-Zilla-App-Command-dumpphases/theme_basic_blue.png"
       alt="Screenshot"
       width="708"
       height="372"/>
</center>

=end html

=cut
