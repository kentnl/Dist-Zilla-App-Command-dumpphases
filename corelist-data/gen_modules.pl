#!/usr/bin/env perl 
use strict;
use warnings;
use utf8;

open my $fh, '>', './modules.zsv';

use Module::CoreList;

my $seen_modules = {};

for my $version ( sort keys %Module::CoreList::version ) {
  my ($hash) = $Module::CoreList::version{$version};
  for my $module ( sort keys %{$hash} ) {
    next if exists $seen_modules->{$module};
    $fh->printf( "%s\0\n", $module );
    $seen_modules->{$module}++;
  }
}

