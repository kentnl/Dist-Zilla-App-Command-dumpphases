#!/usr/bin/env perl 
use strict;
use warnings;
use utf8;

use Module::CoreList;

if ( not $ARGV[0] ) {
  die "GIVE US A PERL VERSION";
}

my $version = $ARGV[0];

use Module::CoreList;

if ( not exists $Module::CoreList::version{$version} ) {
  die "Version $version not in corelist";
}
my ($hash) = $Module::CoreList::version{$version};

open my $fh, '>', './' . $version . '.zsv';

for my $module ( sort keys %{$hash} ) {
  $fh->printf( "%s\0%s\0\n", $module, $hash->{$module} );
}
$fh->close;

