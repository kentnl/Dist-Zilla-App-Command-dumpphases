use strict;
use warnings;

package Dist::Zilla::dumpphases::Theme::basic::red;

# ABSTRACT: A red color theme for C<dzil dumpphases>

=head1 SYNOPSIS

    dzil dumpphases --color-theme=basic::red

=cut

use Moo;

with 'Dist::Zilla::dumpphases::Role::Theme::SimpleColor';

=method C<color>

See L<Dist::Zilla::dumpphases::Role::Theme::SimpleColor/color> for details.

This simply returns C<'red'>

=cut

sub color { return 'red' }

1;
