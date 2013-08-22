use strict;
use warnings;

package Dist::Zilla::dumpphases::Theme::basic::blue;

# ABSTRACT: A blue color theme for C<dzil dumpphases>

=head1 SYNOPSIS

    dzil dumpphases --color-theme=basic::blue

=cut

use Moo;

with 'Dist::Zilla::dumpphases::Role::Theme::SimpleColor';

=method C<color>

See L<Dist::Zilla::dumpphases::Role::Theme::SimpleColor/color> for details.

This simply returns C<'blue'>

=cut

sub color { return 'blue' }

1;
