use strict;
use warnings;

package Dist::Zilla::dumpphases::Theme::basic::green;

# ABSTRACT: A green color theme for C<dzil dumpphases>

=head1 SYNOPSIS

    dzil dumpphases --color-theme=basic::green

=cut

use Moo;

with 'Dist::Zilla::dumpphases::Role::Theme::SimpleColor';

=method C<color>

See L<Dist::Zilla::dumpphases::Role::Theme::SimpleColor/color> for details.

This simply returns C<'green'>

=cut

sub color { return 'green' }

1;
